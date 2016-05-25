require 'elasticsearch/persistence'

class Event < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  mount_uploader :attachment, AttachmentUploader

  after_create :write_to_file
  after_create :broadcast_event
  after_create :save_on_elastic_search
  after_create :slack_it

  # To be able to use type as parameter
  self.inheritance_column = :_type_disabled

  def save_on_elastic_search
    repository = Elasticsearch::Persistence::Repository.new do
      client Elasticsearch::Client.new url: ENV['ELASTICSEARCH_URL'], log: true
      index :events
      type  :event
      klass Event
      settings number_of_shards: 1 do
        mappings dynamic: 'true'
      end
    end
    repository.save(self)
  end

  def write_to_file
    dirPath = "log/#{self.app}"
    if !Dir.exists?(dirPath)
      Dir.mkdir(dirPath)
    end

    filePath = "#{self.user}.log"

    File.open("#{dirPath}/#{filePath}", 'a+') { |file|
      val = ""
      if self.value != nil && !self.value.blank?
        val = "#{self.value} "
      end
      file.write("#{self.timestamp} - #{self.type}.#{self.subtype} #{val}- #{EVENTS_BASE_URL}#{event_path(self)}\n") #
    }
  end

  def channel_name
    return CGI.escape("#{self.app}-#{self.user}")
  end

  def broadcast_event
    # Fiber.new{  }.resume
    WebsocketRails[channel_name].trigger("new_event", socket_object)
  end

  def prettyPayload
    if !payload.blank?
      begin
        jsonPayload = JSON.parse(payload, :quirks_mode => true)
        return JSON.pretty_generate(jsonPayload)
      rescue Exception => e
        return payload
      end
    end
    return ""
  end

  def socket_object(nested = true)
    hash = self.attributes
    hash["timestamp"] = self.timestamp.to_i
    if !payload.blank?
      begin
        if nested
          hash["payload"] = JSON.parse(payload, :quirks_mode => true)
        else
          thePayload = JSON.parse(payload, :quirks_mode => true)
          prefix = Hash.new()
          prefixTitle = "#{self.subtype}".gsub(".", "-")
          prefix[prefixTitle] = thePayload
          hash.merge!(Sparsify.sparse(prefix, :separator => "-" ))
        end
      rescue Exception => e
      end
    end
    return hash
  end

  def to_hash
    return socket_object(false)
  end

  def slack_it
    if subtype == 'GenericParseError' || subtype == 'ResponseFormatError' || subtype == 'MissingDataError'
      slack_hooks.each do |hook|
        notifier = Slack::Notifier.new hook
        unless username.nil?
          notifier.username = "#{self.app}-#{username}"
        else
          notifier.username = self.app
        end
        notifier.ping "#{self.subtype} - #{prettyPayload}"
      end
    end
  end

  def username
    name_event = Event.where(user: user, type: 'Desman.Info').having('timestamp = MAX(timestamp)').pluck(:timestamp, :id, :payload).first

    return nil if name_event.nil?

    begin
      pl = JSON.parse(name_event[2], :quirks_mode => true)
      unless pl['username'].nil?
        user = pl['username']
        return user
      end
    rescue Exception => e
    end
    nil
  end

  def app_config
    return APPS_AUTH[self.app]
  end

  def slack_hooks
    if app_config["slack"]
      return app_config["slack"]
    end
    return nil
  end

end

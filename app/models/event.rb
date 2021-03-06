require 'elasticsearch/persistence'

class Event < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  mount_uploader :attachment, AttachmentUploader

  after_create :write_to_file
  after_create :broadcast_event
  after_create :save_on_elastic_search

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
      file.write("#{self.timestamp} - #{self.type}.#{self.subtype} - #{EVENTS_BASE_URL}#{event_path(self)}\n")
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

end

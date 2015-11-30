class Event < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  mount_uploader :attachment, AttachmentUploader

  # after_create :write_to_file
  # after_create :broadcast_event

  # To be able to use type as parameter
  self.inheritance_column = :_type_disabled

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

  def socket_object
    hash = self.attributes
    hash["timestamp"] = self.timestamp.to_i
    if !payload.blank?
      begin
        hash["payload"] = JSON.parse(payload, :quirks_mode => true)
      rescue Exception => e
      end
    end
    return hash
  end
end

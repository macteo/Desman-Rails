class Event < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  after_create :write_to_file

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

  def prettyPayload
    if !payload.blank?
      return JSON.pretty_generate(JSON.parse(payload))
    else
      return ""
    end
  end
end

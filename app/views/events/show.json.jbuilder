json.extract! @event, :id, :type, :subtype, :uuid, :user, :app, :created_at, :updated_at
if @event.payload
  begin
    json.payload JSON.parse(@event.payload, :quirks_mode => true)
  rescue Exception => e
  end
end
json.timestamp @event.timestamp.to_i
if !@event.attachment.blank?
  json.attachment "#{EVENTS_BASE_URL}#{@event.attachment.url}"
end

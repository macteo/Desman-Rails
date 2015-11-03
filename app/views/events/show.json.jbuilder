json.extract! @event, :id, :type, :subtype, :uuid, :user, :device, :app, :created_at, :updated_at
if @event.payload
  json.payload JSON.parse(@event.payload, :quirks_mode => true)
end
json.timestamp @event.timestamp.to_i
if @event.attachment
  json.attachment "#{EVENTS_BASE_URL}#{@event.attachment.url}"
end

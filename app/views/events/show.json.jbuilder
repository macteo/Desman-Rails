json.extract! @event, :id, :type, :subtype, :timestamp, :uuid, :user, :app, :created_at, :updated_at
if @event.payload
  json.payload JSON.parse(@event.payload)
end

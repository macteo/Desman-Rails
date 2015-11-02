json.extract! @event, :id, :type, :subtype, :uuid, :user, :app, :created_at, :updated_at
if @event.payload
  json.payload JSON.parse(@event.payload)
end
json.timestamp @event.timestamp.to_i

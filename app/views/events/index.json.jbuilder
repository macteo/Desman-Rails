json.array!(@events) do |event|
  json.extract! event, :id, :type, :subtype, :uuid, :user, :app, :device
  json.url event_url(event, format: :json)
  if event.payload
    json.payload JSON.parse(event.payload)
  end
  json.timestamp event.timestamp.to_i
end

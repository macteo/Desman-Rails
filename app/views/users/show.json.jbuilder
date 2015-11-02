json.array!(@events) do |event|
  json.extract! event, :id, :type, :subtype, :uuid, :user, :device, :app
  if event.payload
    json.payload JSON.parse(event.payload)
  end
  json.timestamp event.timestamp.to_i
  json.url event_url(event, format: :json)
end

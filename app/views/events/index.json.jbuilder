json.array!(@events) do |event|
  json.extract! event, :id, :type, :subtype, :timestamp, :uuid, :user, :app
  json.url event_url(event, format: :json)
  if event.payload
    json.payload JSON.parse(event.payload)
  end
end

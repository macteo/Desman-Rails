json.array!(@events) do |event|
  json.extract! event, :id, :type, :subtype, :timestamp, :uuid, :user, :app
  if event.payload
    json.payload JSON.parse(event.payload)
  end
  json.url event_url(event, format: :json)
end

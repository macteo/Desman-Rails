json.array!(@events) do |event|
  json.extract! event, :id, :type, :subtype, :payload, :timestamp, :uuid, :user, :app
  json.url event_url(event, format: :json)
end

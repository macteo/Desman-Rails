json.array!(@events) do |event|
  json.extract! event, :id, :type, :subtype, :uuid, :user, :app
  if event.payload
    json.payload JSON.parse(event.payload)
  end
  json.timestamp event.timestamp.to_i
  json.url event_url(event, format: :json)
  if event.attachment
    json.attachment "#{EVENTS_BASE_URL}#{event.attachment.url}"
  end
end

json.array!(@apps) do |bundle|
  json.bundle bundle
  json.url "#{EVENTS_BASE_URL}/apps/#{bundle}/users"
end

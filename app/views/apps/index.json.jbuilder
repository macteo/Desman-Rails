json.array!(@apps) do |bundle|
  json.bundle bundle
  json.url "#{EVENTS_BASE_URL}/apps/#{bundle}/users"

  if !@names[bundle].blank?
    json.name @names[bundle]
  end
  if !@icons[bundle].blank?
    json.icon EVENTS_BASE_URL + "/uploads/event/attachment/" + @icons[bundle]
  end
end

json.array!(@users) do |user|
  json.user user
  json.url "#{EVENTS_BASE_URL}/apps/#{params[:bundle]}/users/#{user}/events"
end

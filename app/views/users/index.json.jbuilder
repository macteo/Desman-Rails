json.array!(@users) do |user|
  json.user user[0]
  json.device user[1]
  json.url "#{EVENTS_BASE_URL}/apps/#{params[:bundle]}/users/#{user[0]}/events"
end

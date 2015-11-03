json.array!(@users) do |user|
  json.user user
  json.device user[1]
  if !@names[user].blank?
    json.device @names[user]
  end
  if !@icons[user].blank?
    json.image EVENTS_BASE_URL + "/uploads/event/attachment/" + @icons[user]
  end
  json.url "#{EVENTS_BASE_URL}/apps/#{params[:bundle]}/users/#{user}/events"
end

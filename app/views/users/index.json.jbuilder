json.array!(@users) do |user|
  json.extract! user, :id, :f_name, :l_name, :p_number, :email1, :email2
  json.url user_url(user, format: :json)
end

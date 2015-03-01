json.array!(@users) do |user|
  json.extract! user, :id, :name, :email1, :email2, :p_number
  json.url user_url(user, format: :json)
end

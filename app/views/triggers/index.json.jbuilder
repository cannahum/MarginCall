json.array!(@triggers) do |trigger|
  json.extract! trigger, :id, :userEmail, :ticker, :trigger_price
  json.url trigger_url(trigger, format: :json)
end

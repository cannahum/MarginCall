json.array!(@collections) do |collection|
  json.extract! collection, :id, :id, :user_id, :stock_id, :quantity, :market_cap
  json.url collection_url(collection, format: :json)
end

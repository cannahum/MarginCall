module CollectionsHelper
	# this is a method that will help reorganize the parameters
	def reorganize_params(c)
		
		stock_tickers = c.stock_id.split('+')
		quantities = c.quantity.split('+')
		quantities.map! { |q| q.to_f }
		
		
		# use this to store stock objects
		stocks = Array.new

		# use this to store all stock ids into a string
		stock_ids = Array.new

		# use this to store all current prices
		current_prices = Array.new

		stock_tickers.each do |t|
			stock = Stock.find_by(:ticker => t)
			stock_ids.push(stock.id)
			current_prices.push(stock.current_price)
		end

		puts quantities
		puts stock_tickers
		puts stock_ids
		puts current_prices

		
		
		return c
	end
end

module CollectionsHelper
	require 'matrix'

	# this is a method that will help reorganize the parameters
	def reorganize_params(c)
		
		stock_tickers = c.stock_id.split('+')
		quantities = c.quantity.split('+')
		quantities.map! { |q| q.to_f }
		
		# use this to store all stock ids into a string
		stock_ids = Array.new

		# use this to store all current prices
		current_prices = Array.new

		stock_tickers.each do |t|
			stock = Stock.find_by(:ticker => t)
			if stock == nil
				TriggerService.unique_stock t
			end
			stock_ids.push(stock.id)
			current_prices.push(stock.current_price)
		end

		puts stock_ids

		c.stock_id = stock_ids.to_s[1...-1]
		c.quantity = quantities.to_s[1...-1]
		c.total_value = mc(current_prices, quantities)
		c.current_price = 100.0

		return c
	end

	def mc(price, weight)
		# matrix multiplication
		return (Matrix.row_vector(price) * Matrix.column_vector(weight)).element(0,0)
	end
	
end

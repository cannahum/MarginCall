## this file is contains helper methods for the stock controller. 
## for example, high charts!
require 'json'

class StockPresenter

	def initialize(ticker, user)
		@stock_object = Stock.find_by(:ticker => ticker)
    	@stock_ticker = ticker
		@user = user
  	end

	# the high charts method
	def graph_data

		# users triggers for this particular stock
		@user_triggers_for_this_stock = Trigger.where(:userEmail => @user.email1).where(:ticker => @stock_ticker)
		
		# stock data
		@stock_data = HistoricalStockPrice.where(:stock_id => @stock_object.id).pluck(:last_traded_at, :price)
		
		@stock_data.each do |pair|
			pair.map! do |time, price|
				puts "time: #{time}, price: #{price}"
				# time = time.to_time.utc.to_i
	 		# 	price = price.to_f
	 		# 	puts "time: #{time}, price: #{price}"
			end
		end
		puts "stock data is:"
		puts @stock_data

    	return @stock_data
  	end
end
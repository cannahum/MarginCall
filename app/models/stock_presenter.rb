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

		# stock data
		@stock_data = HistoricalStockPrice.where(:stock_id => @stock_object.id).pluck(:last_traded_at, :price)
		
		@stock_data.map! { |time, price| [time.to_time.to_i * 1000, price.to_f] }
		@stock_data.sort_by! { |time, price| time }
		
		# puts "stock data is:"
		# @stock_data.each do |time, price|
		# 	puts "Time: #{time}, Price: #{price}"
		# end

    	return @stock_data
  	end

  	def triggers
  		# users triggers for this particular stock
		@user_triggers_for_this_stock = Trigger.where(:userEmail => @user.email1).where(:ticker => @stock_ticker).where(:triggertype => 'current_price')
		puts @user_triggers_for_this_stock.count
		return @user_triggers_for_this_stock
	end
end
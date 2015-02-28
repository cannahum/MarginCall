require 'open-uri'
require 'csv'


class StockService < ActiveRecord::Base

	
	# This method is for running each ticker through the API call.
	def prepare_stocks
		@stocks_to_check = Stock.all
		@stocks_to_check.each do |stock|
			api_call_and_send(stock)
		end
	end

	def api_call_and_send(stock)
		#please edit the api call through the following string
		api_url = "http://download.finance.yahoo.com/d/quotes.csv?s=#{stock.ticker}&f=sd1t1l1&e=.csv"
		info_array = CSV.new(open(api_url))
		read_csv(stock, info_array)
	end

	def read_csv(stock, info)
		stock.current_price = update_info[3]
		Price.create(ticker:line[1], price:line[2])
	end
end
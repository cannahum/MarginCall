require 'open-uri'
require 'csv'

class StockService < ActiveRecord
	def scheduled_start
		@stocks_to_check = Stock.all
		@stocks_to_check.each do |stock|
			api_call_and_send(stock)
		end
	end

	def api_call_and_send(stock)
		CSV.new(open("http://download.finance.yahoo.com/d/quotes.csv?s=#{ticker}&f=nsl1&e=.csv")).each do |line|
			read_csv(line) 
		end
	end

	def read_csv(line)
		Price.create(ticker:line[1], price:line[2])
	end
end
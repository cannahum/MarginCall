class HistoricalStockPrice < ActiveRecord::Base
require 'date'

	def self.record_historical_price(stock, date, time)
		p = HistoricalStockPrice.new

		p.stock_id = stock.id
		p.price = stock.current_price
		date_and_time = p.create_datetime date, time 
		p.last_traded_at = date_and_time

		puts "we got back from create_datetime and date and time are: #{p.last_traded_at}"

		if p.last_traded_at != HistoricalStockPrice.maximum("last_traded_at")
			p.save
		end
	end	


	def create_datetime(date, time)
		date_array = date.split("/")
		month = date_array[0]
		day = date_array[1]
		year = date_array[2]

		morning = time[-2..1]
		minute = time[-4..-3]
		hour = time[0...time.rindex(":")]
		unless morning == 'pm'
			hour = hour.to_i + 12
		end

		return DateTime.new(year.to_i, month.to_i, day.to_i, hour.to_i, minute.to_i)
	end

end

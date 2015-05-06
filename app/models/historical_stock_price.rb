class HistoricalStockPrice < ActiveRecord::Base
require 'date'

	def self.record_historical_price(stock, date, time)
		create_datetime stock, date, time 
	end	


	def create_datetime(stock, date, time)
		date_array = date.split("/")
		month = date_array[0]
		day = date_array[1]
		year = date_array[2]

		morning = time[-2..1]
		minute = time[-4..-3]
		hour = time[0...time.rindex(":")]
		if morning == 'pm'
			hour = hour.to_i + 12
		end

		save_historical_price stock, DateTime.new(year.to_i, month.to_i, day.to_i, hour.to_i, minute.to_i)
	end

	def save_historical_price(stock, dt)
		p = HistoricalStockPrice.new

		p.stock_id = stock.id
		p.price = stock.current_price
		p.last_traded_at = dt

		if p.last_traded_at != HistoricalStockPrice.maximum("last_traded_at") && p.price > 0
			p.save
		end
	end

end
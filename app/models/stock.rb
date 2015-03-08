require 'open-uri'
require 'csv'

class Stock < ActiveRecord::Base
	validates :ticker, :current_price, presence: true
	validates :current_price, numericality: true
	validates :ticker, uniqueness: true

	
	def api_call_and_send
		#please edit the api call through the following string
		api_url = "http://download.finance.yahoo.com/d/quotes.csv?s=#{ticker}&f=sd1t1l1g0h0&e=.csv"
		info_array = CSV.new(open(api_url))
		return info_array
	end

	def read_csv(info)
		current_price = info[3]
		daily_min_price = info[4]
		daily_max_price = info[5]
		save
		# Price.create(ticker:line[1], price:line[2])
	end
end

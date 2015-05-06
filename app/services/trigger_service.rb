module TriggerService
	# this function checks if a ticker specified by a trigger is included in
	# the stock table. If it's not, as in if it's a new stock, then add it to
	# the stock table, and call an api to get a name.
	def self.unique_stock(ticker)
				
		s = Stock.where(ticker: ticker)
		if s.count != 0
			if Stock.find_by(ticker: ticker).collection == false
				Stock.create(ticker: ticker, current_price: 0)
				api_url = "http://download.finance.yahoo.com/d/quotes.csv?s=#{ticker}&f=nab"
				info = CSV.new(open(api_url))
				s = Stock.find_by(ticker: ticker)
				info.each do |row|
					s[:company_name] = row[0]
				end	
				puts "just created stock #{s.ticker}"
				s.save
			end
		end
	end
end
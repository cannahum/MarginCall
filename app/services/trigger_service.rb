module TriggerService
	# this function checks if a ticker specified by a trigger is included in
	# the stock table. If it's not, as in if it's a new stock, then add it to
	# the stock table, and call an api to get a name.
	def self.unique_stock(ticker)
		if Stock.where(ticker: ticker).size == 0
			Stock.create(ticker: ticker, current_price: 0)
			api_url = "http://download.finance.yahoo.com/d/quotes.csv?s=#{ticker}&f=nab"
			info = CSV.new(open(api_url))
			s = Stock.find_by(ticker: ticker)
			info.each do |row|
				s[:company_name] = row[0]
			end
			s.save
		end
	end
end




# # Probably need the texting, email

# # this class is a service through which the application will be checking if a trigger
# # is realized. If the stock price has reached a user's trigger, then the user gets
# # notified.
# class TrigerService < ActiveRecord::Base

# 	Trigger.all.each do |trigger_record|
# 		current_price = Stock.find(trigger_record[1])
# 		difference = ((trigger_record[2] - current_price) / trigger_record[2]).abs
# 		if difference == 0
# 			contacttrigger trigger_record
# 		elsif difference <= 0.01
# 			contact1 trigger_record current_price
# 		elsif difference <= 0.05
# 			contact5 trigger_record current_price
# 		end
# 	end
	


# 	def contact5
# 	end

# 	def contact1
# 	end

# 	def contacttrigger
# 	end
# end
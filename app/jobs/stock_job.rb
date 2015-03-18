class StockJob

	# helps create the String that goes into the api, sends the request
    def self.perform
        ActiveRecord::Base.connection_pool.with_connection do
        	stock_string = construct_stock_string
      	    info = api_call_and_send(stock_string)
    	end
    end

    def self.test_perform
    	puts "Testing"
    end

    # constructs a string of ticker names for the api call.
    def self.construct_stock_string
    	stocks = Array.new
    	Stock.all.each do |stock|
    		stocks.push(stock[:ticker])
    	end

    	ticker_string = stocks[0]
  		(1...stocks.length()).each do |i|
  			ticker_string = ticker_string + "+" + stocks[i]
  		end

  		return ticker_string
  	end

  	# takes the ticker string, attaches it appropriately to the api url
  	# and returns a csv file.
  	def self.api_call_and_send(ticker_string)
  		api_url = "http://download.finance.yahoo.com/d/quotes.csv?s=#{ticker_string}&f=sd1t1l1gh"
		info = CSV.new(open(api_url))
		currentprice = Array.new()
		index=1
		info.each do |row|
			Stock.find(index)[:current_price] = row[3].to_f
			puts "#{Stock.find(index)[:name]}: #{Stock.find(index)[:current_price]}"
		end
  	end
end

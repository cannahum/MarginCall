class StockJob
	require 'bigdecimal'
	require 'bigdecimal/util'

	# helps create the String that goes into the api, sends the request
  def self.perform
    ActiveRecord::Base.connection_pool.with_connection do
    stock_string = construct_stock_string
    api_call_and_send(stock_string)
    end
  end

  # constructs a string of ticker names for the api call.
  def self.construct_stock_string	
    ticker_string = ""
  	Stock.all.each do |stock|
  			ticker_string << "+" + stock[:ticker]
  	end
    
    #return the string from the first element to the last. (ignore the initial "+")
    return ticker_string[1..-1]
  end

  # takes the ticker string, attaches it appropriately to the api url
  # and returns a csv file.
  def self.api_call_and_send(ticker_string)
  	api_url = "http://download.finance.yahoo.com/d/quotes.csv?s=#{ticker_string}&f=sd1t1l1gh"
		info = CSV.new(open(api_url))
    index=Stock.first[:id]
		info.each do |row|
      s = Stock.find(index)
      s[:current_price] = row[3]
      s.save
		  index += 1
    end
  end
end

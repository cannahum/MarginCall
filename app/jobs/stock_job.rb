class StockJob
	require 'bigdecimal'
	require 'bigdecimal/util'

	# helps create the String that goes into the api, sends the request
  def self.perform
    ActiveRecord::Base.connection_pool.with_connection do
    stock_string = construct_stock_string
      if stock_string != nil
        puts "the string is #{stock_string}"
        api_call_and_send(stock_string)
      end
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

    retrieval = "sd1t1l1ghydm6m8j6k5ver2"
    ### EXPLANATION: ###
    #in order: s:symbol, d1:Last Trade Date, t1: Last Trade Time:, 
    #l1: last trade price, g: day's low, h: day's high, y: dividend yield, 
    #d: dividend per share, m6: Percent Change From 200 Day Moving Average, 
    #m8: Percent Change From 50 Day Moving Average, j6: Percent Change From 52 week Low, 
    #k5: Percent Change From 52 week High, v: Volume, e: Earnings per Share, r2: P/E Ratio

    api_url = "http://download.finance.yahoo.com/d/quotes.csv?s=#{ticker_string}&f=#{retrieval}"
    info = CSV.new(open(api_url))
    index=Stock.first[:id]
		info.each do |row|
      s = Stock.find(index)
      s[:current_price] = row[3]
      s[:daily_min_price] = row[4]
      s[:daily_max_price] = row[5]
      s[:dividend_yield] = row[6]
      s[:dividend_per_share] = row[7]
      s[:percentchange_from200day_avg] = row[8]
      s[:percentchange_from50day_avg] = row[9]
      s[:percentchange_from52week_low] = row[10]
      s[:percentchange_from52week_high] = row[11]
      s[:volume] = row[12]
      s[:eps] = row[13]
      s[:pe_ratio] = row[14]
      
      s.save
		  index += 1
    end
  end
end

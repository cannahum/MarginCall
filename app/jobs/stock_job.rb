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

    retrieval = "sd1t1l1ghydm6m8j6k5ver"
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
      HistoricalStockPrice.record_historical_price s, row[1], row[2]
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



# =begin
 
#  def self.update_collections
#  @collection = Collection.all
#  @collection.each do |collection|
#  ticker_array = collection.ticker_array
#  weight_array = collection.weight_array
 
#  price_array = Array.new
#  dividend_yield_array = Array.new
#  dividend_per_share_array = Array.new
#  percentchange_from200day_avg_array = Array.new
#  percentchange_from50day_avg_array = Array.new
#  percentchange_from52week_low_array = Array.new
#  percentchange_from52week_high_array = Array.new
#  volume_array = Array.new
#  eps_array = Array.new
#  pe_ratio_array = Array.new
 
#  ticker_array.each do |ticker|
 
#  s = Stock.find_by ticker:(ticker)
#  price_array.push(s[:current_price])
#  dividend_yield_array.push(s[:dividend_yield])
#  dividend_per_share_array.push(s[:dividend_per_share])
#  percentchange_from200day_avg_array.push(s[:percentchange_from200day_avg])
#  percentchange_from50day_avg_array.push(s[:percentchange_from50day_avg])
#  percentchange_from52week_low_array.push(s[:percentchange_from52week_low])
#  percentchange_from52week_high_array.push(s[:percentchange_from52week_high])
#  volume_array.push(s[:volume])
#  eps_array.push(s[:eps])
#  pe_ratio_array.push(s[:pe_ratio])
 
 
#  end
#  #now we have an array for each element and a corresponding weighting array
 
#  price, dividend_yield, dividend_per_share, percentchange_from200day_avg, percentchange_from50day_avg, percentchange_from52week_low, percentchange_from52week_high, volume, eps, pe_ratio = 0,0,0,0,0,0,0,0,0,0
 
#  i, size = 0, weight_array.size
#  while i < size
#  price += weight_array[i] * price_array[i]
#  dividend_yield += weight_array[i] * dividend_yield_array[i]
#  dividend_per_share += weight_array[i] * dividend_per_share_array[i]
#  percentchange_from200day_avg += weight_array[i] * percentchange_from200day_avg_array[i]
#  percentchange_from50day_avg += weight_array[i] * percentchange_from50day_avg_array[i]
#  percentchange_from52week_low += weight_array[i] * percentchange_from52week_low_array[i]
#  percentchange_from52week_high += weight_array[i] * percentchange_from52week_high_array[i]
#  volume += weight_array[i] * volume_array[i]
#  eps += weight_array[i] * eps_array[i]
#  pe_ratio += weight_array[i] * pe_ratio_array[i]
 
#  i += 1
#  end
 
#  #now we have values we can store for this collection
 
#  collection[:price] = price
#  collection[:dividend_yield] = dividend_yield
#  collection[:dividend_per_share] = dividend_per_share
#  collection[:percentchange_from200day_avg] = percentchange_from200day_avg
#  collection[:percentchange_from50day_avg] = percentchange_from50day_avg
#  collection[:percentchange_from52week_low] = percentchange_from52week_low
#  collection[:percentchange_from52week_high] = percentchange_from52week_high
#  collection[:volume] = volume
#  collection[:eps] = eps
#  collection[:pe_ratio] = pe_ratio
 
#  collection.save
 
 
#  end
#  end
 
#  =end

end

class CollectionJob
	require 'bigdecimal'
	require 'bigdecimal/util'
 
 	def self.update_collections
 		@collection = Collection.all
 		
 		@collection.each do |c|
 			user = c.user_id.to_s
 			stocks = c.stock_id.split(',')
 			quantities = c.quantity.split(',')
 			index_value = c.current_price
 			total_value = c.total_value

 			stocks.map! { |s| s.to_i }
 			quantities.map! { |w| w.to_f }
 			total = weights.reduce :+
 			weights = quantities.map { |w| w / total }
			
			price_array = Array.new
			dividend_yield_array = Array.new
			dividend_per_share_array = Array.new
			percentchange_from200day_avg_array = Array.new
			percentchange_from50day_avg_array = Array.new
 			percentchange_from52week_low_array = Array.new
 			percentchange_from52week_high_array = Array.new
 			volume_array = Array.new
 			eps_array = Array.new
 			pe_ratio_array = Array.new
 
 			stocks.each do |i|
 				s = Stock.find(i)
 				price_array << s[:current_price].to_f
 				dividend_yield_array << s[:dividend_yield].to_f
 				dividend_per_share_array << s[:dividend_per_share].to_f
 				percentchange_from200day_avg_array << s[:percentchange_from200day_avg].to_f
				percentchange_from50day_avg_array << s[:percentchange_from50day_avg].to_f
				percentchange_from52week_low_array << s[:percentchange_from52week_low].to_f
				percentchange_from52week_high_array << s[:percentchange_from52week_high].to_f
				volume_array << s[:volume].to_f
				eps_array << s[:eps].to_f
				pe_ratio_array << s[:pe_ratio].to_f
			end

			#now we have an array for each element and a corresponding weighting array
 
			new_total_value, dividend_yield, dividend_per_share, percentchange_from200day_avg, percentchange_from50day_avg, percentchange_from52week_low, percentchange_from52week_high, volume, eps, pe_ratio = 0,0,0,0,0,0,0,0,0,0
 
			i, size = 0, weights.size

 			while i < size
 				new_total_value += quantities[i] * price_array[i]
 				dividend_yield += weights[i] * dividend_yield_array[i]
 				dividend_per_share += weights[i] * dividend_per_share_array[i]
 				percentchange_from200day_avg += weights[i] * percentchange_from200day_avg_array[i]
				percentchange_from50day_avg += weights[i] * percentchange_from50day_avg_array[i]
 				percentchange_from52week_low += weights[i] * percentchange_from52week_low_array[i]
 				percentchange_from52week_high += weights[i] * percentchange_from52week_high_array[i]
 				volume += volume_array[i]
 				eps += weights[i] * eps_array[i]
 				pe_ratio += weights[i] * pe_ratio_array[i]
 				i += 1
			end
 
			#now we have values we can store for this collection
 
			c_id_in_stock_table = Stock.find_by(:ticker => "#{c.user_id},#{@c.nickname}")
			sample_stock_id = Stock.find(stocks.first).id
			dt = HistoricalStockPrice.where(:stock_id => sample_stock_id).maximum("last_traded_at")
 			
 			HistoricalStockPrice.save_historical_price c_id_in_stock_table, dt
			c[:total_value] = new_total_value
			c[:current_price] = index_value * (1 + (new_total_value / total_value - 1))
			c[:dividend_yield] = dividend_yield
			c[:dividend_per_share] = dividend_per_share
			c[:percentchange_from200day_avg] = percentchange_from200day_avg
			c[:percentchange_from50day_avg] = percentchange_from50day_avg
			c[:percentchange_from52week_low] = percentchange_from52week_low
			c[:percentchange_from52week_high] = percentchange_from52week_high
			c[:volume] = volume
			c[:eps] = eps
			c[:pe_ratio] = pe_ratio
			 
			c.save
		end
	end
end

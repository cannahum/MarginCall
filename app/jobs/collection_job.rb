class CollectionJob
	require 'bigdecimal'
	require 'bigdecimal/util'
 
 	def self.update_collections
 		@collection = Collection.all
 		
 		@collection.each do |c|
 			stocks = c.stock_id.split(',')
 			weights = c.quantity.split(',')

 			stocks.map! { |s| s.to_i }
 			weights.map! { |w| w.to_f }
			
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
 				price_array << s[:current_price]
 				dividend_yield_array << s[:dividend_yield]
 				dividend_per_share_array << s[:dividend_per_share]
 				percentchange_from200day_avg_array << s[:percentchange_from200day_avg]
				percentchange_from50day_avg_array << s[:percentchange_from50day_avg]
				percentchange_from52week_low_array << s[:percentchange_from52week_low]
				percentchange_from52week_high_array << s[:percentchange_from52week_high]
				volume_array << s[:volume]
				eps_array.push << s[:eps]
				pe_ratio_array.push << s[:pe_ratio]
			end

			#now we have an array for each element and a corresponding weighting array
 
			price, dividend_yield, dividend_per_share, percentchange_from200day_avg, percentchange_from50day_avg, percentchange_from52week_low, percentchange_from52week_high, volume, eps, pe_ratio = 0,0,0,0,0,0,0,0,0,0
 
			i, size = 0, weights.size
 			while i < size
 				price += weights[i] * price_array[i]
 				dividend_yield += weights[i] * dividend_yield_array[i]
 				dividend_per_share += weights[i] * dividend_per_share_array[i]
 				percentchange_from200day_avg += weights[i] * percentchange_from200day_avg[i]
				percentchange_from50day_avg += weights[i] * percentchange_from50day_avg_array[i]
 				percentchange_from52week_low += weights[i] * percentchange_from52week_low_array[i]
 				percentchange_from52week_high += weights[i] * percentchange_from52week_high_array[i]
 				volume += volume_array[i]
 				eps += weights[i] * eps_array[i]
 				pe_ratio += weights[i] * pe_ratio_array[i] 
 				i += 1
			end
 
			#now we have values we can store for this collection
 
			collection[:price] = price
			collection[:dividend_yield] = dividend_yield
			collection[:dividend_per_share] = dividend_per_share
			collection[:percentchange_from200day_avg] = percentchange_from200day_avg
			collection[:percentchange_from50day_avg] = percentchange_from50day_avg
			collection[:percentchange_from52week_low] = percentchange_from52week_low
			collection[:percentchange_from52week_high] = percentchange_from52week_high
			collection[:volume] = volume
			collection[:eps] = eps
			collection[:pe_ratio] = pe_ratio
			 
			collection.save
		end
	end
end

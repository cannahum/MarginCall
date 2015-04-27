## this file is contains helper methods for the stock controller. 
## for example, high charts!

class StockPresenter

	def initialize(ticker, user)
		@stock_object = Stock.find_by(:ticker => ticker)
    @stock_ticker = ticker
		@user = user
  end

	# the high charts method
	def draw_graph

		# users triggers for this particular stock
		@user_triggers_for_this_stock = Trigger.where(:userEmail => @user.email1).where(:ticker => @stock_ticker)
		
		# stock data
		stock_data = HistoricalStockPrice.where(:stock_id => @stock_object.id).pluck(:last_traded_at, :price)
		@time = []
		@price = []

		stock_data.map do |time, price| 
			@time << time
			@price << price
		end


		@chart = LazyHighCharts::HighChart.new('graph') do |f|
  			f.title(:text => "#{@stock_object.company_name}")
  			
  			f.xAxis(:type => 'datetime', dateTimeLabelFormats: {
                							second: '%Y-%m-%d<br/>%H:%M:%S',
                							minute: '%Y-%m-%d<br/>%H:%M',
                							hour: '%Y-%m-%d<br/>%H:%M',
                							day: '%Y<br/>%m-%d',
                							week: '%Y<br/>%m-%d',
               		 						month: '%Y-%m',
                							year: '%Y'})

  			
  			index = 1
  			# @user_triggers_for_this_stock.each do |trigger|
  				
  			# 	f.series (:name => "Trigger #{index}", :yAxis => trigger.trigger_price)
  				
  			# 	#f.series(:name => "GDP in Billions", :yAxis => 0, :data => [14119, 5068, 4985, 3339, 2656])
  			# 	#f.series(:name => "Population in Millions", :yAxis => 1, :data => [310, 127, 1340, 81, 65])

  			# 	index += 1
  			# end

  			f.series(:type => 'line', :name => 'Price', data: @price, pointStart: @time.first)
  
  			f.yAxis [
    			{:title => {:text => "Price", :margin => 70} }
    		]

  			f.legend(:align => 'right', :verticalAlign => 'top', :y => 75, :x => -50, :layout => 'vertical',)
  			f.chart({:defaultSeriesType=>"column"})
  	end
  end
end
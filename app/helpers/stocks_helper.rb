## this file is contains helper methods for the stock controller. 
## for example, high charts!

module StocksHelper

	# the high
	def draw_graph(stock_ticker)

		# @stock_id = Stock.where(:ticker => stock_ticker)
		# @user = User.find(:id)
		# @user_triggers_for_this_stock = Trigger.where(:userEmail => @user.email1).where(:ticker => stock_ticker)
		
		# @time = HistoricalStockPrice.where(:stock_id => @stock_id).last_traded_at

		# @chart = LazyHighCharts::HighChart.new('graph') do |f|
  # 			f.title(:text => "#{stockID.company_name}")
  			
  # 			f.xAxis(:type => 'datetime', dateTimeLabelFormats: {
  #               							second: '%Y-%m-%d<br/>%H:%M:%S',
  #               							minute: '%Y-%m-%d<br/>%H:%M',
  #               							hour: '%Y-%m-%d<br/>%H:%M',
  #               							day: '%Y<br/>%m-%d',
  #               							week: '%Y<br/>%m-%d',
  #              		 						month: '%Y-%m',
  #               							year: '%Y'} )
  			
  # 			index = 1
  # 			@user_triggers_for_this_stock.each do |trigger|
  				
  # 				f.series (:name => "Trigger #{index}", :yAxis => trigger.trigger_price)
  				
  # 				#f.series(:name => "GDP in Billions", :yAxis => 0, :data => [14119, 5068, 4985, 3339, 2656])
  # 				#f.series(:name => "Population in Millions", :yAxis => 1, :data => [310, 127, 1340, 81, 65])

  # 				index += 1
  # 			end

  # 			f.yAxis [
  #   			{:title => {:text => "GDP in Billions", :margin => 70} },
  #   			{:title => {:text => "Population in Millions"}, :opposite => true},
  # 			]

  # 			f.legend(:align => 'right', :verticalAlign => 'top', :y => 75, :x => -50, :layout => 'vertical',)
  # 			f.chart({:defaultSeriesType=>"column"})
  # 		end
  	end
end
require 'test_helper'

class StockServiceTest < ActiveSupport::TestCase

	test "test is running" do
		puts 'yes im running check two'
	end

	test "url is composed" do
		ticker = 'AAPL'
		
	
	end
	
 	test "data is retrieved" do
 		stock = StockService.new
 		stock.prepare_stocks
		assert stock.invalid?
		puts 'stocktest ran'
	end


end

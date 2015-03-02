require 'test_helper'

class StockTest < ActiveSupport::TestCase
  	fixtures :stocks

 	test "stock fields must not be empty" do
 		stock = Stock.new
		assert stock.invalid?
		assert stock.errors[:ticker].any?
		assert stock.errors[:current_price].any?
	end

	test "stock price must be a number" do
		stock = Stock.new(ticker: 'AAPL')

		stock.current_price = 'lame'
		assert stock.invalid?
		assert_equal 'is not a number', stock.errors[:current_price].join('; ')

		stock.current_price = 100
		assert stock.valid?
	end

	test "this stock is already in the system" do
		stock = Stock.new(ticker: stocks(:one).ticker, current_price: 3)
		assert stock.invalid?
		assert_equal ["has already been taken"], stock.errors[:ticker]
	end
end

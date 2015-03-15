require 'test_helper'

class TriggerTest < ActiveSupport::TestCase
 	fixtures :triggers

 	test "trigger fields must not be empty" do
 		trigger = Trigger.new
		assert trigger.invalid?
		assert trigger.errors[:ticker].any?
		assert trigger.errors[:trigger_price].any?
	end

	test "trigger price must be a number" do
		trigger = Trigger.new(ticker: 'AAPL', userEmail: 'my@email.com')

		trigger.trigger_price = 'lame'
		assert trigger.invalid?
		assert_equal 'is not a number', trigger.errors[:trigger_price].join('; ')

		trigger.trigger_price = 100
		assert trigger.valid?
	end

end

class TriggerJob
	# This class will go through the trigger table, see if there is a trigger to be invoked,
	# then alert its user

	def self.perform
		@triggers = Trigger.all
		@triggers.each do |trigger|
			t_price = trigger[:trigger_price]
			stock = Stock.find(trigger[:stock_id])
			user = User.find(trigger[:user_id])

			if stock[:daily_min_price] < t_price && t_price < stock[daily_max_price]
				puts "trigger that shit!"
			else
				difference = (t_price - stock[:current_price]).abs / stock[:current_price]
				if difference < 0.01
					puts "within 1% range"
				end
			end
		end
	end
	
end
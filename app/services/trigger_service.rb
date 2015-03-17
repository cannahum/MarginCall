# Probably need the texting, email

# this class is a service through which the application will be checking if a trigger
# is realized. If the stock price has reached a user's trigger, then the user gets
# notified.
class TriggerService

	Trigger.all.each do |trigger_record|
		current_price = Stock.find(trigger_record[1])
		difference = ((trigger_record[2] - current_price) / trigger_record[2]).abs
		if difference == 0
			contacttrigger trigger_record
		elsif difference <= 0.01
			contact1 trigger_record current_price
		elsif difference <= 0.05
			contact5 trigger_record current_price
		end
	end
	


	def contact5
	end

	def contact1
	end

	def contacttrigger
	end
end
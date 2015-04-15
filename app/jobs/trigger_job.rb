class TriggerJob
	# This class will go through the trigger table, see if there is a trigger to be invoked,
	# then alert its user

	def self.perform
		@triggers = Trigger.all
		@triggers.each do |trigger|
			t_price = trigger[:trigger_price]
            stock = Stock.find_by ticker: (trigger[:ticker])
            user = User.find_by email1: (trigger[:userEmail])

    if stock[:daily_min_price] < t_price && t_price < stock[:daily_max_price]
				puts "trigger that shit!"
                UserMailer.trigger_email(user, trigger).deliver_now
			else
				difference = (t_price - stock[:current_price]).abs / stock[:current_price]
				if difference < 0.01
					puts "within 1% range"
                    UserMailer.trigger_email(user, trigger).deliver_now
				end
			end
		end
	end

=begin

    def self.perform
        @triggers = Trigger.all
        @triggers.each do |trigger|
            
            
            
            

            #s[:current_price] = row[3]
            #s[:daily_min_price] = row[4]
            #s[:daily_max_price] = row[5]
            
            #s[:dividend_yield] = row[6]
            #s[:dividend_per_share] = row[7]
            #s[:percentchange_from200day_avg] = row[8]
            #s[:percentchange_from50day_avg] = row[9]
            #s[:percentchange_from52week_low] = row[10]
            #s[:percentchange_from52week_high] = row[11]
            #s[:volume] = row[12]
            #s[:earnings_per_share] = row[13]
            #s[:PE_ratio] = row[14]
            
            trigger_type = trigger[:type]#this is a string

            stock = Stock.find_by ticker: (trigger[:ticker])
            user = User.find(trigger[:user_id])
            comparison = trigger[:comparison]
            c_value = findvalue(stock, trigger_type)
            t_value = trigger[trigger_price]
            
            triptrigger = evaluate(c_value, t_value, comparison)
            
            if triptrigger==true
                puts "trigger that shit!"
                UserMailer.trigger_email(user, trigger).deliver_now
            end
            
        end
    end
        


    def self.findvalue(stock, type)

        value = 0
        case type
        when "current_price"
            value = stock[:current_price]
        when "dividend_yield"
            value = stock[:dividend_yield]
        when "dividend_per_share"
            value = stock[:dividend_per_share]
        when "percentchange_from200day_avg"
            value = stock[:percentchange_from200day_avg]
        when "percentchange_from50day_avg"
            value = stock[:percentchange_from50day_avg]
        when "percentchange_from52week_low"
            value = stock[:percentchange_from52week_low]
        when "percentchange_from52week_high"
            value = stock[:percentchange_from52week_high]
        when "volume"
            value = stock[:volume]
        when "earnings_per_share"
            value = stock[:earnings_per_share]
        when "PE_ratio"
            value = stock[:PE_ratio]
        else
            puts "Big problem"
        end
        return value
    end

    def self.evaluate(c_value, t_value, comparison)

        bool trigger = false;
        case comparison
        when "g"
            if c_value > t_value
                trigger = true
            end
        when "e"
            if c_value==t_value
                trigger=true
            end
        when "l"
            if c_value < t_value
                trigger=true
            end
        else
            puts "Big Problem"
        end

    end
 
=end

end
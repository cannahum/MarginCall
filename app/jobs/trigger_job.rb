class TriggerJob
	# This class will go through the trigger table, see if there is a trigger to be invoked,
	# then alert its user

	def self.perform
		@triggers = Trigger.all
		@triggers.each do |trigger|
            if trigger[:active]==true
                t_value = trigger[:trigger_price]
                security = Stock.where(ticker: (trigger.ticker))[0]

                if security == nil
                    security = Collections.where(nickname: trigger.ticker)[0]
                end
                user = User.find_by email1: (trigger[:userEmail])
                comparison = trigger[:comparison]
                type = trigger[:triggertype]
                c_value = TriggerJob.findvalue(security, type)
                activate = TriggerJob.evaluate(c_value, t_value, comparison)
                
                if activate ==true
                    UserMailer.trigger_email(user, trigger).deliver_now
                    trigger[:active] = false;
                    trigger.save
                end
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
        when "eps"
            value = stock[:eps]
        when "pe_ratio"
            value = stock[:pe_ratio]
        else
            puts "Big problem"
        end
        puts "This shit be called!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
        puts " THIS SHIT IS THE VALUE     #{value}     !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
        return value
    end

    def self.evaluate(c_value, t_value, comparison)

        trigger = false;
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
        return trigger
    end


end
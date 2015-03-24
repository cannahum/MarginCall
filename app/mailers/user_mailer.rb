class UserMailer < ApplicationMailer
	default from: "margincall.cosi166b@gmail.com"
	def welcome_email(user)
		@user = user
		mail(to: @user.email1, subject: 'Welcome to Margin Call')
	end
    
    def trigger_email(user, trigger)
        @user = user
        @trigger= trigger
        mail(to: @user.email1, subject: "#{@trigger.ticker} Trigger Alert")
    end
    
    
    
    
end

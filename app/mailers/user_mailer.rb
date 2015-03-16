class UserMailer < ApplicationMailer
	default from: "margincall.cosi166b@gmail.com"
	def welcome_email(user)
		@user = user
		mail(to: @user.email1, subject: 'test email')
	end
end

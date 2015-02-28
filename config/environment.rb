# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!


# sending emails

MarginCall::Application.configure do
	config.action_mailer.delivery_method = :smtp

	config.action_mailer.smtp_settings = {
		address: "smtp.gmail.com",
		port: 587,
		domain: "imap.gmail.com",
		authentication: "margincall.cosi166b",
		password: "margincall12345",
		enable_starttls_auto: true
	}
end

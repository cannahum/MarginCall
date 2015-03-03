ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  	# Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  	fixtures :all

  	#Logs in as a test user
	def login_as(user, options = {})
		password	= options[:password]	|| 'password'
		remember_me = options[:remember_me] || 'me'
		if integration_test?
			post login_path, session: {email1: user.email1,
										password: password,
										remember_me: remember_me }

		else
			session[:user_id] = users(user).id
		end
	end

	def logout
		session.delete :user_id
	end

	def setup
		login_as :michael if defined? session
	end

	# Returns true if a test user is logged in.
	def is_logged_in?
		!session[:user_id].nil?
	end


	private

	#returns true inside an integration test
	def integration_test?
		defined?(post_via_redirect)
	end

end

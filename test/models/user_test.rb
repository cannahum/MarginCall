require 'test_helper'

class UserTest < ActiveSupport::TestCase

	def setup
		@user = User.new(name: "Example User", email1:"user@example.com", password:"password", password_confirmation: "password")
	end

	test "authenticated? should return false for a user with nil digest" do
		assert_not @user.authenticated?('')
	end
end

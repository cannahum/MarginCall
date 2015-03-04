require 'test_helper'
require 'pry'
require 'pry-byebug'

class UsersSignupTest < ActionDispatch::IntegrationTest

	test "invalid signup information" do
		get new_user_path
		assert_no_difference 'User.count' do
			post users_path, user: {    name: "",
									 	email1: "user@invalid",
										password: "foo",
										password_confirmation: "bar" }
		end
		assert_template 'users/new'
	end

	test "valid signup information" do
		get new_user_path
		assert_difference 'User.count', 1 do
			post users_path, user: {    name: "Example User",
									 	email1: "user@example.com",
										password: "password",
										password_confirmation: "password" }
		end
		assert_redirected_to controller: 'homepage', action: 'index'
		assert is_logged_in?
	end

end

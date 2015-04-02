require 'test_helper'

class UsersEditTest <ActionDispatch::IntegrationTest

	def setup
		@user = users(:michael)
		@other_user = users(:susannah)
	end

	test "unsuccessful edit fails" do
		login_as(@user)
		get edit_user_path(@user)
		assert_template 'users/edit'
		patch user_path(@user), user: {
			name: '',
			email1: "food@food",
			password: "foo",
			password_confirmation: "dbar"
		}
		assert_template 'users/edit'
	end

	test "user can successfully edit" do
		login_as(@user)
		get edit_user_path(@user)
		assert_template 'users/edit'
		name = "Paul"
		email = "food@food.com"
		patch user_path(@user), user: {
			name: name,
			email1: email,
			password: "monkey",
			password_confirmation: "monkey"
		}
		assert_not flash.empty?
		assert_redirected_to @user
		@user.reload
		assert_equal @user.name, name
		assert_equal @user.email1, email
	end


end
require 'test_helper'

class UsersEditTest <ActionDispatch::IntegrationTest

	def setup
		@user = users(:michael)
	end

	test "unsuccessful edit" do
		get edit_user_path(@user)
		assert_template 'users/edit'
		patch user_path(@user), user: {
			name: '',
			email: "food@food",
			password: "foo",
			password_confirmation: "dbar"
		}
		assert_template 'users/edit'
	end

end
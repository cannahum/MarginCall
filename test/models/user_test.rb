require 'test_helper'

class UserTest < ActiveSupport::TestCase
	fixtures :users

	test "user attributes must not be empty" do
		user = User.new	
		assert user.invalid?
		assert user.errors[:f_name].any?
		assert user.errors[:l_name].any?
		assert user.errors[:email1].any?
	end

end

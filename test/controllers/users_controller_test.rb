require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:michael)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    patch :update, id: @user, user: { email1: @user.email1, email2: @user.email2, name: @user.name, p_number: @user.p_number, password: 'secret', password_confirmation: 'secret' }
    assert_redirected_to @user
  end

  #test "should destroy user" do
  #  assert_difference('User.count', -1) do
  #    delete :destroy, id: @user
  #  end

  #  assert_redirected_to homepage_url
  #end
end

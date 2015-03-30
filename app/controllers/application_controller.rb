class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	include SessionsHelper
	include TriggersHelper

	def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
    def correct_user
      @user = User.find(params[:id])
      redirect_to homepage_url, notice: 'User is not the correct user' unless current_user?(@user)
    end
    def admin_user
      redirect_to homepage_url, notice: 'Only Admins may do that' unless admin?
    end

	
end
class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	helper_method :sanitize_trigger_type
  include SessionsHelper
	include TriggersHelper
  include CollectionsHelper


	def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
    def correct_user
      # id_to_check = params[:id].to_integer
      if User.count <= params[:id].to_i
        @user = User.find(params[:id])
        redirect_to homepage_url, notice: 'User is not the correct user' unless current_user?(@user)
      else
        redirect_to homepage_url, notice: 'User does not exist'
      end
    end
    def admin_user
      redirect_to homepage_url, notice: 'Only Admins may do that' unless admin?
    end
    def sanitize_trigger_type(trigger_type)
      all_triggers = {"current_price"=> "Price", "dividend_yield"=> "Dividend Yield", "dividend_per_share"=> "Dividend Per Share", "pe_ratio"=> "PE Ratio",
      "percentchange_from200day_avg"=> 'Percent Change From 200 Day Moving Avg', "percentchange_from50day_avg"=> 'Percent Change From 50 Day Moving Avg',
      "percentchange_from52week_low"=> 'Percent Change From 52 Week Low', "percentchange_from52week_high"=> 'Percent Change From 52 Week high',
      "volume"=> "Volume", "eps"=> 'Earnings Per Share'}
      return all_triggers[trigger_type]
    end
	
end
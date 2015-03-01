class ApplicationController < ActionController::Base
	before_action :authorize
	#old comments that I probably shouldn't have deleted
	protected

		def authorize
			unless User.find_by(id: session[:user_id])
				redirect_to login_url, notice: "Please log in"
			end
		end
end
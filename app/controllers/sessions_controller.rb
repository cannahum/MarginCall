class SessionsController < ApplicationController
    def new
      if logged_in?
        redirect_to homepage_url
      end
    end

  	def create
      user = User.find_by(email1: params[:session][:email1].downcase)
      if user && user.authenticate(params[:session][:password])
        # Log the user in and redirect to user's show page
          log_in user
          params[:session][:remember_me] == '1' ? remember(user) : forget(user)
          redirect_back_or user
      else
        #fuck shit 
        flash.now[:danger] = 'Invalid email/password combination'
        render 'new'
      end  
	  end

    def destroy
      log_out if logged_in?
      redirect_to homepage_url
  	end
end

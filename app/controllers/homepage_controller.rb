class HomepageController < ApplicationController
	skip_before_action :authorize
  	def index
  		@stocks = Stock.order(:ticker)
  	end
end

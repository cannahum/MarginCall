class HomepageController < ApplicationController
	before_action :authorize
  	def index
  		@stocks = Stock.order(:ticker)
  	end
end

class HomepageController < ApplicationController
	def index
  		@stocks = Stock.order(:ticker)
  	end
end

class AdminController < ApplicationController
  	def index
  		@open_triggers = Trigger.count
  	end
end

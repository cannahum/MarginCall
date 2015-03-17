class UpdateStockJob < ActiveJob::Base
	include SuckerPunch::Job
    queue_as :default

    def perform(stock_id)
        ActiveRecord::Base.connection_pool.with_connection do
      	    new_csv = api_call_and_send(stock_id)
    	end
    end
end

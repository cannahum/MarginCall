class BackgroundProcessor
	include SuckerPunch::Job

	
	def initialize
	end

	def perform
		StockJob.perform
		CollectionJob.update_collections
        TriggerJob.perform
		BackgroundProcessor.new.async.later(15)
	end

	def later(sec)
		after(sec) {
			perform
		}
	end
end
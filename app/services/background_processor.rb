class BackgroundProcessor
	include SuckerPunch::Job

	
	def initialize
	end

	def perform
		StockJob.perform
		BackgroundProcessor.new.async.later(15)
	end

	def later(sec)
		after(sec) {
			perform
		}
	end
end
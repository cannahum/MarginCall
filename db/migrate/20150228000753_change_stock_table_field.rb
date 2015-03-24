class ChangeStockTableField < ActiveRecord::Migration
  	def change
  		remove_column :stocks, :trigger_price
  	end
end

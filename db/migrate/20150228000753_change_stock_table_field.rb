class ChangeStockTableField < ActiveRecord::Migration
  def change
  	change_table :stocks do |entry|
  		entry.remove :trigger_price
  	end
  end
end

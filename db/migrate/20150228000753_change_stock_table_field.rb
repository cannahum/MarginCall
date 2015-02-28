class ChangeStockTableField < ActiveRecord::Migration
  def change
  	change_table :stocks do |entry|
  		entry.remove :trigger_price
  		entry.decimal :current_price
  	end
  end
end

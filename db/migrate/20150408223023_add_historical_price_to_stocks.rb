class AddHistoricalPriceToStocks < ActiveRecord::Migration
  def change
  	add_column :stocks, :historical_price, :decimal, array: true, default: []
  	add_column :stocks, :historical_time, :datetime, array: true, default: []
  end
end

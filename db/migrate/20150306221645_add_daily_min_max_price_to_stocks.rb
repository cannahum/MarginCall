class AddDailyMinMaxPriceToStocks < ActiveRecord::Migration
  def change
    add_column :stocks, :daily_min_price, :decimal, precision: 8, scale: 2
    add_column :stocks, :daily_max_price, :decimal, precision: 8, scale: 2
  end
end

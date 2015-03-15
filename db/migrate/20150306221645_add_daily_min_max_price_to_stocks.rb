class AddDailyMinMaxPriceToStocks < ActiveRecord::Migration
  def change
    add_column :stocks, :daily_min_price, :decimal
    add_column :stocks, :daily_max_price, :decimal
  end
end

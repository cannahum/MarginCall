class CreateHistoricalStockPrices < ActiveRecord::Migration
  def change
    create_table :historical_stock_prices do |t|
      t.integer :stock_id
      t.decimal :price
      t.datetime :last_traded_at

      t.timestamps null: false
    end
  end
end

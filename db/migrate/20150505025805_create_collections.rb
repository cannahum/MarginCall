class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.integer :user_id
      t.string :nickname
      t.string :stock_id
      t.string :quantity
      t.decimal :total_value
      t.decimal :current_price
      t.decimal :daily_min_price, precision: 8, scale: 2
      t.decimal :daily_max_price, precision: 8, scale: 2
      t.decimal :dividend_yield, precision: 8, scale: 2
      t.decimal :dividend_per_share, precision: 8, scale: 2
      t.decimal :percentchange_from200day_avg, precision: 8, scale: 2
      t.decimal :percentchange_from50day_avg, precision: 8, scale: 2
      t.decimal :percentchange_from52week_low, precision: 8, scale: 2
      t.decimal :percentchange_from52week_high, precision: 8, scale: 2
      t.decimal :volume, precision: 8, scale: 2
      t.decimal :eps, precision: 8, scale: 2
      t.decimal :pe_ratio, precision: 8, scale: 2

      t.timestamps null: false
    end
  end
end

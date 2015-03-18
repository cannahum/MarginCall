class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.string :ticker
      t.string :company_name
      t.decimal :current_price, precision: 8, scale: 2

      t.timestamps null: false
      #hello
    end
  end
end

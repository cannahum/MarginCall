class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.integer :user_id
      t.string :stock_id
      t.string :quantity
      t.string :market_cap

      t.timestamps null: false
    end
  end
end

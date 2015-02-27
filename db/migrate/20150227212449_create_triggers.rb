class CreateTriggers < ActiveRecord::Migration
  def change
    create_table :triggers do |t|
      t.string :userEmail
      t.string :ticker
      t.decimal :trigger_price, precision: 8, scale: 2

      t.timestamps null: false
    end
  end
end

class AddCollectionBooleanToStocks < ActiveRecord::Migration
  def change
  	add_column :stocks, :collection, :boolean, :default => false
  end
end

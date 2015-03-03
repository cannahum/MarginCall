class AddIndexToUsersEmail1 < ActiveRecord::Migration
  def change
  	add_index :users, :email1, unique: true
  end
end

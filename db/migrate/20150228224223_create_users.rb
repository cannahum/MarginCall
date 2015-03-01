class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :password_digest
      t.string :email1
      t.string :email2
      t.string :p_number

      t.timestamps null: false
    end
  end
end

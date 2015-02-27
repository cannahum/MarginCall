class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :f_name
      t.string :l_name
      t.string :p_number
      t.string :email1
      t.string :email2

      t.timestamps null: false
    end
  end
end

class AddNewTriggerFields < ActiveRecord::Migration
  def change
      add_column :triggers, :triggertype, :string
      add_column :triggers, :comparison, :string
      add_column :triggers, :active, :boolean
  end
end

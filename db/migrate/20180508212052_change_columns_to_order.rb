class ChangeColumnsToOrder < ActiveRecord::Migration[5.1]
  def change
    remove_column :orders, :completed, :boolean
  end
end

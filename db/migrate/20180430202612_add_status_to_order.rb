class AddStatusToOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :state, :string, default: 'in_progress'
  end
end

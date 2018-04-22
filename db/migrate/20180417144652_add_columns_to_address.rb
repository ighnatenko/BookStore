class AddColumnsToAddress < ActiveRecord::Migration[5.1]
  def change
    add_column :addresses, :address_type, :integer

    remove_column :orders, :completed_date, :datetime
    add_column :orders, :use_billing, :boolean, default: false , null: false
    add_column :orders, :completed_date, :datetime
  end
end

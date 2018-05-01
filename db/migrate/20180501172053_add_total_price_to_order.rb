class AddTotalPriceToOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :total_price, :decimal, precision: 10, scale: 2, default: 0
  end
end

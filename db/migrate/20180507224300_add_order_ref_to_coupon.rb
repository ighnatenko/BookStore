class AddOrderRefToCoupon < ActiveRecord::Migration[5.1]
  def change
    add_reference :coupons, :order, index: true
    add_column :coupons, :code, :string, null: false
    remove_column :coupons, :title, :string
    remove_column :coupons, :available, :boolean
    remove_column :coupons, :discount, :decimal
    add_column :coupons, :discount, :decimal, null: false
  end
end
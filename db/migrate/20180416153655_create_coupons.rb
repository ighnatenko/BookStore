class CreateCoupons < ActiveRecord::Migration[5.1]
  def change
    create_table :coupons do |t|
      t.string :title, null: false
      t.decimal :discount, default: 0, null: false
      t.boolean :available, null: false

      t.timestamps
    end
  end
end

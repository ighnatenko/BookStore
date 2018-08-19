# frozen_string_literal: true

# CreateOrders
class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.decimal :summary_price, precision: 10, scale: 2
      t.boolean :completed, default: false, null: false
      t.datetime :completed_date, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

# frozen_string_literal: true

# AddDeliveryRefToOrder
class AddDeliveryRefToOrder < ActiveRecord::Migration[5.1]
  def change
    add_reference :orders, :delivery, foreign_key: true
  end
end

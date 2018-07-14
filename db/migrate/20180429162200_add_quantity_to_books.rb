# frozen_string_literal: true

class AddQuantityToBooks < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :quantity, :integer, default: 0
  end
end

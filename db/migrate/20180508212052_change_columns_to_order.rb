# frozen_string_literal: true

# ChangeColumnsToOrder
class ChangeColumnsToOrder < ActiveRecord::Migration[5.1]
  def change
    remove_column :orders, :completed, :boolean
  end
end

# frozen_string_literal: true

# AddColumnsToBook
class AddColumnsToBook < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :best_seller, :boolean, default: false
  end
end

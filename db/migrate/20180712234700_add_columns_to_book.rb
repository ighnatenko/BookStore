# frozen_string_literal: true

class AddColumnsToBook < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :popular, :boolean, default: false
    add_column :books, :best_seller, :boolean, default: false
  end
end

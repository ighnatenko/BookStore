# frozen_string_literal: true

# AddColumnsToUser
class AddColumnsToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :name, :string
    add_column :users, :image, :text
  end
end

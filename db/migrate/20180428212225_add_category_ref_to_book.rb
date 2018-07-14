# frozen_string_literal: true

class AddCategoryRefToBook < ActiveRecord::Migration[5.1]
  def change
    add_reference :books, :category, foreign_key: true
  end
end

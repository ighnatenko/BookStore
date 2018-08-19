# frozen_string_literal: true

# CreateAuthors
class CreateAuthors < ActiveRecord::Migration[5.1]
  def change
    create_table :authors do |t|
      t.string :firstname, null: false
      t.string :lastname, null: false
      t.text :description, null: false

      t.timestamps
    end
  end
end

# frozen_string_literal: true

# CreateImages
class CreateImages < ActiveRecord::Migration[5.1]
  def change
    create_table :images do |t|
      t.string 'url', null: false
      t.references :book, foreign_key: true

      t.timestamps
    end
  end
end

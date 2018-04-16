class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.decimal :price, precision: 10, scale: 2, null: false
      t.decimal :width, precision: 4, scale: 1, null: false
      t.decimal :height, precision: 4, scale: 1, null: false
      t.decimal :depth, precision: 4, scale: 1, null: false
      t.integer :publication_year, null: false
      t.string :materials, null: false

      t.timestamps
    end
  end
end

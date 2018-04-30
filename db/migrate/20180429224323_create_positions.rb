class CreatePositions < ActiveRecord::Migration[5.1]
  def change
    create_table :positions do |t|
      t.references :book, foreign_key: true
      t.references :order, foreign_key: true
      t.integer :quantity, default: 0

      t.timestamps
    end
  end
end

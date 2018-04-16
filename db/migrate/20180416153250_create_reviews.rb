class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.text :description, null: false
      t.integer :rating, null: false

      t.timestamps
    end
  end
end

class CreateCreditCards < ActiveRecord::Migration[5.1]
  def change
    create_table :credit_cards do |t|
      t.string :number
      t.string :cvv, limit: 3
      t.date :expiration
      t.string :owner
      t.references :order, foreign_key: true

      t.timestamps
    end
  end
end

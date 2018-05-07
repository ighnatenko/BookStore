class ChangeColumnsCreditCard < ActiveRecord::Migration[5.1]
  def change
    add_reference :credit_cards, :cardable, polymorphic: true, index: true
    add_column :credit_cards, :card_name, :string, null: false
    add_column :credit_cards, :expiration_date, :string, null: false
    remove_column :credit_cards, :expiration
    remove_column :credit_cards, :owner
    remove_column :credit_cards, :order_id
  end
end
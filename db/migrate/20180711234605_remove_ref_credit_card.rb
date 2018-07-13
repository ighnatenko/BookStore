class RemoveRefCreditCard < ActiveRecord::Migration[5.1]
  def change
    remove_reference :credit_cards, :cardable
    add_reference :credit_cards, :order, foreign_key: true
  end
end

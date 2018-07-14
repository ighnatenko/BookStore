# frozen_string_literal: true

class ChangeColumnsCreditCard < ActiveRecord::Migration[5.1]
  def change
    add_column :credit_cards, :card_name, :string, null: false
    add_column :credit_cards, :expiration_date, :string, null: false
    remove_column :credit_cards, :expiration
  end
end

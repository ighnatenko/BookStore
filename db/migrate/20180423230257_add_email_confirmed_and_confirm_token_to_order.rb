# frozen_string_literal: true

# AddEmailConfirmedAndConfirmTokenToOrder
class AddEmailConfirmedAndConfirmTokenToOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :email_confirmed, :boolean, default: false
    add_column :orders, :confirmation_token, :string
  end
end

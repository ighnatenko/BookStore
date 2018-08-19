# frozen_string_literal: true

module FeatureHelper
  def sign_in(user)
    visit new_user_session_path
    fill_in 'email', with: user.email
    fill_in 'password', with: user.password
    first('[name = commit]').click
  end

  def add_book_to_cart(book)
    page.driver.post cart_item_path(items: { price: book.price,
                                             quantity: 1, book_id: book.id })
    visit root_path
  end

  def fill_address(type, address)
    fill_in("address_#{type}_form_firstname", with: address.firstname)
    fill_in("address_#{type}_form_lastname", with: address.lastname)
    fill_in("address_#{type}_form_address", with: address.address)
    fill_in("address_#{type}_form_city", with: address.city)
    fill_in("address_#{type}_form_zipcode", with: address.zipcode)
    select('Ukraine', from: "address_#{type}_form_country")
    fill_in("address_#{type}_form_phone", with: address.phone)
  end

  def fill_credit_card(card)
    fill_in('payment_number', with: card.number)
    fill_in('payment_card_name', with: card.card_name)
    fill_in('payment_expiration_date', with: card.expiration_date)
    fill_in('payment_cvv', with: card.cvv)
  end
end

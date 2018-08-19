# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Cart', type: :feature do
  let(:book) { create(:book).decorate }

  background { visit root_path }

  scenario 'add a book' do
    expect(page).to have_css('.shop-icon', text: '0')
    add_book
    visit root_path
    expect(page).to have_css('.shop-icon', text: '1')
    click_link('shop-link')
    expect(page).to have_content(I18n.t('checkout.checkout'))
  end

  scenario 'delete a book' do
    add_book
    visit root_path
    click_link('shop-link')
    first('.close.general-cart-close').click
    expect(page).to have_content(I18n.t('cart.empty_cart'))
  end

  private

  def add_book
    page.driver.post cart_item_path(items: { price: book.price,
                                             quantity: 1, book_id: book.id })
  end
end

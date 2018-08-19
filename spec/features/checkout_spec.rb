# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Checkout', type: :feature do
  let(:user) { create(:user) }
  let(:book) { create(:book).decorate }
  let!(:order) { create(:order, user: user, delivery: nil) }
  let(:credit_card) { create(:credit_card) }
  let(:delivery) { create(:delivery) }

  let(:billing_address) do
    order.addresses.create(FactoryBot.attributes_for(:address, :billing))
  end

  let(:shipping_address) do
    order.addresses.create(FactoryBot.attributes_for(:address, :shipping))
  end

  background { sign_in(user) }
  background { add_book_to_cart(book) }

  context 'checkout all step' do
    scenario 'address step' do
      visit checkout_index_path(locale: I18n.locale)
      expect(page).to have_current_path('/en/checkout/address')
      expect(page.text).to include(I18n.t('checkout.address'),
                                   I18n.t('checkout.delivery'),
                                   I18n.t('checkout.payment'),
                                   I18n.t('checkout.confirm'),
                                   I18n.t('checkout.complete'))
      fill_address(:billing, billing_address)
      fill_address(:shipping, shipping_address)
      click_button(I18n.t('checkout.save'))
      expect(page).to have_current_path('/en/checkout/delivery')
    end

    scenario 'delivery step' do
      create_addresses
      order.update(delivery: delivery)

      visit checkout_path(id: :delivery, locale: I18n.locale)
      first('.hidden-xs .radio-label').click
      click_button('deliveries-submit-btn')
      expect(page).to have_current_path('/en/checkout/payment')
    end

    scenario 'payment step' do
      create_addresses
      order.update(delivery: delivery)

      visit checkout_path(id: :payment, locale: I18n.locale)
      expect(page).to have_current_path('/en/checkout/payment')

      fill_credit_card(credit_card)
      click_button(I18n.t('checkout.save'))
      expect(page).to have_current_path('/en/checkout/confirm')
    end

    scenario 'confirm and complete step' do
      create_addresses
      order.update(delivery: delivery)
      order.update(credit_card: credit_card)

      visit checkout_path(id: :confirm, locale: I18n.locale)
      expect(page).to have_current_path('/en/checkout/confirm')

      click_on(I18n.t('checkout.place_order'))
      expect(page).to have_current_path('/en/checkout/complete')
      expect(page).to have_css('.general-subtitle',
                               text: I18n.t('checkout.thank_for_order'))
    end
  end

  context 'checkout editing steps' do
    background do
      create_addresses
      order.update(delivery: delivery)
      order.update(credit_card: credit_card)
      visit checkout_path(id: :confirm, locale: I18n.locale)
    end

    scenario 'address step' do
      visit checkout_path(id: :address, locale: I18n.locale)
      expect(page).to have_current_path('/en/checkout/address')
      click_button(I18n.t('checkout.save'))
      expect(page).to have_current_path('/en/checkout/confirm')
    end

    scenario 'delivery step' do
      visit checkout_path(id: :delivery, locale: I18n.locale)
      expect(page).to have_current_path('/en/checkout/delivery')
      click_button('deliveries-submit-btn')
      expect(page).to have_current_path('/en/checkout/confirm')
    end

    scenario 'payment step' do
      visit checkout_path(id: :payment, locale: I18n.locale)
      expect(page).to have_current_path('/en/checkout/payment')
      click_button(I18n.t('checkout.save'))
      expect(page).to have_current_path('/en/checkout/confirm')
    end
  end

  context 'checkout steps with invalid params' do
    scenario 'address step' do
      visit checkout_path(id: :address, locale: I18n.locale)
      expect(page).to have_current_path('/en/checkout/address')
      click_button(I18n.t('checkout.save'))
      expect(page).to have_current_path('/en/checkout/address')
    end

    scenario 'delivery step' do
      create_addresses
      visit checkout_path(id: :delivery, locale: I18n.locale)
      expect(page).to have_current_path('/en/checkout/delivery')
      click_button('deliveries-submit-btn')
      expect(page).to have_current_path('/en/checkout/delivery')
    end

    scenario 'payment step' do
      create_addresses
      order.update(delivery: delivery)

      visit checkout_path(id: :payment, locale: I18n.locale)
      expect(page).to have_current_path('/en/checkout/payment')
      click_button(I18n.t('checkout.save'))
      expect(page).to have_current_path('/en/checkout/payment')
    end
  end

  private

  def create_addresses
    order.addresses.create(FactoryBot.attributes_for(:address, :billing))
    order.addresses.create(FactoryBot.attributes_for(:address, :shipping))
  end
end

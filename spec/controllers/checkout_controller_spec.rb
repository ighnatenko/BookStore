# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CheckoutController, type: :controller do
  let!(:user) { create(:user) }

  let(:shipping_address_params) do
    FactoryBot.attributes_for(:address, :shipping)
  end

  let(:billing_address_params) do
    FactoryBot.attributes_for(:address, :billing)
  end

  let(:delivery) { FactoryBot.create(:delivery) }
  let(:credit_card_params) { FactoryBot.attributes_for(:credit_card) }

  before { sign_in(user) }

  describe 'GET #address' do
    it 'show address' do
      get :index, params: { locale: I18n.locale }
      expect(assigns(:order)).not_to be_nil
      expect(response.status).to eq(302)
    end
  end

  describe 'PUT #address' do
    it 'update address' do
      put :update, params: { id: :address,
                             address: {
                               billing_form: billing_address_params,
                               shipping_form: shipping_address_params
                             },
                             locale: I18n.locale }
      expect(assigns(:order)).not_to be_nil
      expect(assigns(:order).addresses.count).to eq(2)
      expect(response.status).to eq(302)
    end
  end

  describe 'GET #delivery' do
    it 'show delivery' do
      get :show, params: { id: :delivery, locale: I18n.locale }
      expect(response.status).to eq(302)
    end
  end

  describe 'PUT #delivery' do
    it 'update delivery' do
      put :update, params: { id: :delivery,
                             delivery: delivery.id,
                             locale: I18n.locale }
      expect(assigns(:order).delivery_id).to eq(delivery.id)
      expect(response.status).to eq(302)
    end
  end

  describe 'GET #payment' do
    it 'show payment' do
      get :show, params: { id: :payment, locale: I18n.locale }
      expect(response.status).to eq(302)
    end
  end

  describe 'PUT #payment' do
    it 'update payment' do
      put :update, params: { id: :payment,
                             payment: credit_card_params,
                             locale: I18n.locale }
      expect(assigns(:order).credit_card).not_to be_nil
      expect(response.status).to eq(302)
    end
  end

  describe 'GET #confirm' do
    it 'show confirm' do
      get :show, params: { id: :confirm, locale: I18n.locale }
      expect(response.status).to eq(302)
    end
  end
end

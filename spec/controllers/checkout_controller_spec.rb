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
                             billing_address: billing_address_params,
                             shipping_address: shipping_address_params,
                             locale: I18n.locale }
      expect(assigns(:order)).not_to be_nil
      expect(assigns(:order).addresses.count).to eq(2)
      expect(response.status).to eq(302)
    end
  end

  describe 'GET #delivery' do
    it 'show delivery' do
      put :update, params: { id: :address,
                             billing_address: billing_address_params,
                             shipping_address: shipping_address_params,
                             locale: I18n.locale }
      get :show, params: { id: :delivery, locale: I18n.locale }
      expect(assigns(:order).addresses.count).to eq(2)
      expect(response.status).to eq(302)
    end
  end
end

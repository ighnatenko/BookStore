# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AddressesController, type: :controller do
  let(:user) { create(:user) }
  let(:address) { user.addresses.create(FactoryBot.attributes_for(:address, :shipping).stringify_keys) }
  let(:address_params) { FactoryBot.attributes_for(:address, :shipping).stringify_keys }
  let(:invalid_address_params) { FactoryBot.attributes_for(:address, :invalid).stringify_keys }

  before { allow(controller).to receive(:current_user).and_return(user) }

  describe 'POST #create' do
    context 'with valid attributes' do
      before { post :create, params: { address: address_params } }

      it 'redirect to user settings' do
        expect(response).to redirect_to(edit_user_registration_path)
      end

      it 'show notice' do
        expect(flash[:notice]).to eq I18n.t('address.successful.create')
      end

      it 'creates address' do
        expect { post :create, params: { address: address_params } }.to change(Address, :count).by(1)
      end
    end

    context 'with invalid params' do
      before { post :create, params: { address: invalid_address_params } }
      it 'redirects to user settings page' do
        expect(response).to redirect_to(edit_user_registration_path)
      end

      it 'show alert' do
        expect(flash[:alert]).to eq I18n.t('address.failure.create')
      end
    end
  end

  describe 'PATCH #update' do
    before { allow(controller).to receive(:current_user).and_return user }

    context 'with valid attributes' do
      before { patch :update, params: { id: address.id, address: address_params } }
      it 'assigns @address' do
        expect(assigns(:address)).not_to be_nil
      end

      it 'sends success notice' do
        expect(flash[:notice]).to eq I18n.t('address.successful.update')
      end

      it 'redirects to user settings' do
        expect(response).to redirect_to(edit_user_registration_path)
      end
    end

    context 'with forbidden attributes' do
      it 'generates ParameterMissing error without address params' do
        expect { patch :update, params: { id: address.id } }.to raise_error(ActionController::ParameterMissing)
      end
    end

    context 'with invalid attributes' do
      before do
        patch :update, params: { id: address.id, address: invalid_address_params }
      end

      it 'sends error flash' do
        expect(flash[:alert]).to eq I18n.t('address.failure.update')
      end

      it 'redirects to user settings page' do
        expect(response).to redirect_to(edit_user_registration_path)
      end
    end
  end
end

require 'rails_helper'

RSpec.describe CheckoutController, type: :controller do
  let(:user) { create(:user) }

  before { allow(controller).to receive(:current_user).and_return(user) }

  describe "PUT #address" do
    before { put :address }

    it 'assigns items' do
      expect(assigns(:billing_address)).to be_nil
      expect(assigns(:shipping_address)).to be_nil
    end

    it 'has a 302 status code' do
      expect(response.status).to eq(302)
    end
  end
end

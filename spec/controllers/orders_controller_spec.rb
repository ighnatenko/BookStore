# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  let(:user) { create(:user) }
  let!(:order) { create(:order, user: user, state: 'delivered') }

  before { allow(controller).to receive(:current_user).and_return(user) }

  describe 'GET #index' do
    context 'successful load' do
      before do
        get :index, params: { locale: I18n.locale },
                    session: { order_id: order.id }
      end

      it 'assigns @items' do
        expect(assigns(:orders)).not_to be_nil
      end

      it 'has a 200 status code' do
        expect(response.status).to eq(302)
      end
    end
  end

  describe 'GET #show' do
    before do
      get :show, params: { id: order.id, locale: I18n.locale },
                 session: { order_id: order.id }
    end

    it 'assigns @items' do
      expect(assigns(:order)).not_to be_nil
    end

    it 'renders :index template' do
      expect(response).to render_template(:show)
    end

    it 'has a 200 status code' do
      expect(response.status).to eq(200)
    end
  end
end

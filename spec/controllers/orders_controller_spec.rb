# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  let(:user) { create(:user) }
  let!(:order) { create(:order, user: user, state: 'delivered') }

  before { allow(controller).to receive(:current_user).and_return(user) }

  describe 'GET #index' do
    context 'successful load' do
      before do
        get :index, session: { order_id: order.id }
      end

      it 'assigns @items' do
        expect(assigns(:orders)).not_to be_nil
      end

      it 'renders :index template' do
        expect(response).to render_template(:index)
      end

      it 'has a 200 status code' do
        expect(response.status).to eq(200)
      end
    end
  end

  describe 'GET #show' do
    before do
      get :show, params: { id: order.id }, session: { order_id: order.id }
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

    context 'calling needed methods' do
      after do
        get :show, params: { id: order.id }, session: { order_id: order.id }
      end

      it 'finds needed order' do
        expect(Order).to receive(:find_by).with(id: order.id.to_s)
                                          .and_call_original
      end
    end
  end
end

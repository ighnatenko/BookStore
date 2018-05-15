require 'rails_helper'

RSpec.describe CartController, type: :controller do
  let(:user) { create(:user) }
  let(:book) { create(:book) }
  let(:order) { create(:order, user: user) }
  let(:cart_params) { { price: rand(10..20), quantity: rand(2..5), book_id: book.id } }

  before { allow(controller).to receive(:current_user).and_return(user) }

  describe 'GET #index' do
    before { get :index, session: { order_id: order.id } }
 
    it 'assigns @items' do
      expect(assigns(:items)).not_to be_nil
    end

    it 'renders :index template' do
      expect(response).to render_template(:index)
    end

    it 'has a 200 status code' do
      expect(response.status).to eq(200)
    end
  end

  describe 'POST #add_item' do
    it 'add item' do
      add_item
      expect(Position.find_by(order_id: order.id, book_id: book.id)).not_to be_nil
    end
  end

  describe 'DELETE #destroy' do
    it 'removes item from cart' do
      add_item
      expect(Position.find_by(order_id: order.id, book_id: book.id)).not_to be_nil
      delete :destroy, params: { book_id: book.id }
      expect(Position.find_by(order_id: order.id, book_id: book.id)).to be_nil
      expect(flash[:notice]).to eq I18n.t('cart.removed')
    end
  end

  def add_item
    session[:order_id] = order.id
    post :add_item, params: { items: cart_params }
  end
end

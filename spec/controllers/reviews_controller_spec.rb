# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  let!(:book) { create(:book) }
  let!(:user) { create(:user) }

  before { allow(controller).to receive(:current_user).and_return(user) }

  describe 'POST #create' do
    context 'valid attributes' do
      before do
        params = { rating: 5, review: { description: 'test' },
                   book_id: book.id, user_id: user.id,
                   locale: I18n.locale }
        expect { post :create, params: params }.to change(Review, :count).by(1)
      end

      it 'redirect to user settings' do
        expect(response).to redirect_to(book_path(book))
      end

      it 'show notice' do
        expect(flash[:notice]).to eq I18n.t('review.successful.create')
      end
    end

    context 'invalid params' do
      before do
        params = { review: { description: 'test' },
                   book_id: book.id, user_id: user.id,
                   locale: I18n.locale }
        post :create, params: params
      end

      it 'redirect to user settings' do
        expect(response).to redirect_to(book_path(book))
      end

      it 'show notice' do
        expect(flash[:alert]).to eq I18n.t('review.failure.create')
      end
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  let(:user) { create(:user) }
  let(:book) { create(:book) }

  describe 'GET #show' do
    it 'assigns variables' do
      allow(controller).to receive(:current_user).and_return user
      get :show, params: { id: book.id }
      expect(assigns(:book)).not_to be_nil
    end
  end
end

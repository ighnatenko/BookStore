# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe 'GET #index' do
    before { get :index, params: { locale: I18n.locale } }
    it 'assigns variables' do
      expect(:slider_books).not_to be_nil
      expect(:best_seller_books).not_to be_nil
    end

    it 'renders :index template' do
      expect(response).to render_template(:index)
    end

    it 'has a 200 status code' do
      expect(response.status).to eq(200)
    end
  end
end

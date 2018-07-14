# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let(:book) { FactoryBot.create(:book) }

  describe 'GET #index' do
    before { get :index }
    it 'assigns @books' do
      expect(assigns(:books)).not_to be_nil
    end

    it 'has a 200 status code' do
      expect(response.status).to eq(200)
    end

    it 'renders :index template' do
      expect(response).to render_template(:show)
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: book.category.id } }

    it 'assigns @books' do
      expect(assigns(:books)).not_to be_nil
    end

    it 'has a 200 status code' do
      expect(response.status).to eq(200)
    end

    it 'renders :show template' do
      expect(response).to render_template(:show)
    end
  end
end

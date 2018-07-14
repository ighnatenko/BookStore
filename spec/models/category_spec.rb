# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:category) { FactoryBot.create :category }

  context 'field validation' do
    it { should validate_presence_of(:title) }
  end

  context 'associations' do
    it { should have_many(:books).dependent :delete_all }
  end
end

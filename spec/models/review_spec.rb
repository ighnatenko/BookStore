# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Review, type: :model do
  let(:review) { FactoryBot.create :review }

  context 'field validation' do
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:rating) }
  end

  context 'associations' do
    it { should belong_to(:book) }
    it { should belong_to(:user) }
  end
end

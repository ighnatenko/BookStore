# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Image, type: :model do
  let(:image) { FactoryBot.create :image }

  context 'field validation' do
    it { should validate_presence_of(:url) }
  end

  context 'associations' do
    it { should belong_to(:book) }
  end
end

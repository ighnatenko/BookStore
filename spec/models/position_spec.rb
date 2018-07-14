# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Position, type: :model do
  let(:position) { FactoryBot.create :position }

  context 'field validation' do
    it { should validate_presence_of(:quantity) }
  end

  context 'associations' do
    it { should belong_to(:book) }
    it { should belong_to(:order) }
  end
end

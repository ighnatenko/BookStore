# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:image) { FactoryBot.create :image }

  context 'field validation' do
    it { should validate_presence_of(:tracking_number) }
    it { should validate_presence_of(:state) }
  end

  context 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:addresses).dependent :destroy }
    it { should have_one(:credit_card) }
    it { should have_many(:positions) }
    it { should have_many(:books).through :positions }
    it { should belong_to(:delivery) }
    it { should have_one(:coupon) }
  end
end

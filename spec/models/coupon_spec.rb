# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Coupon, type: :model do
  let(:coupon) { FactoryBot.create :coupon }

  context 'field validation' do
    it { should validate_presence_of(:code) }
    it { should validate_presence_of(:discount) }
    it { validate_length_of(:code).is_at_most(6..10) }
  end

  context 'associations' do
    it { should belong_to(:order) }
  end
end

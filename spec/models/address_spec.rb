# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Address, type: :model do
  let(:address) { FactoryBot.create :address }

  context 'field validation' do
    %i[firstname lastname address city zipcode
       country phone address_type].each do |field|
      it "invalid without #{field}" do
        is_expected.to validate_presence_of(field)
      end
    end
  end

  context 'associations' do
    it 'belongs to addressable' do
      is_expected.to belong_to(:addressable)
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Book, type: :model do
  let(:book) { FactoryBot.create :book }

  context 'field validation' do
    %i[title price materials].each do |field|
      it "invalid without #{field}" do
        is_expected.to validate_presence_of(field)
      end
    end

    %i[height width depth].each do |field|
      it { is_expected.to validate_numericality_of(field).is_greater_than_or_equal_to 0 }
    end

    it { should validate_numericality_of(:publication_year).is_less_than_or_equal_to Time.current.year }
  end

  context 'associations' do
    it { should have_many(:images).dependent :destroy }
    it { should belong_to(:category) }
    it { should have_and_belong_to_many(:authors) }
    it { should have_many(:positions) }
    it { should have_many(:orders).through :positions }
    it { should have_many(:reviews).dependent :destroy }
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Delivery, type: :model do
  let(:delivery) { FactoryBot.create :delivery }

  context 'field validation' do
    %i[title days price].each do |field|
      it { is_expected.to validate_presence_of(field) }
    end
  end

  context 'associations' do
    it { should have_many(:orders).dependent :nullify }
  end
end

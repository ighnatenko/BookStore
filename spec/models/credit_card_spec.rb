require 'rails_helper'

RSpec.describe CreditCard, type: :model do
  let(:credit_card) { FactoryBot.create :credit_card }
  
  context 'field validation' do
    %i[number cvv expiration_date card_name].each do |field|
      it { is_expected.to validate_presence_of(field) }
    end
  end

  context 'associations' do
    it { should belong_to(:cardable) }
  end
end
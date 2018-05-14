FactoryBot.define do
  factory :order do
    summary_price { rand(100..200) }
    state { 'in_progress' }
    tracking_number { "R#{Time.now.strftime('%d%m%y%H%M%S')}" }
    total_price { rand(100..200) }
    delivery
  end
end
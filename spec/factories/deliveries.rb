FactoryBot.define do
  factory :delivery do
    title { FFaker::Book.title }
    days { FFaker::Book.description }
    price { rand(10...20) }
  end
end
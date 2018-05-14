FactoryBot.define do
  factory :author do
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name }
    description { Faker::StarWars.wookiee_sentence }
  end
end
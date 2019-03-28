# frozen_string_literal: true

ShoppingCart::Delivery.destroy_all
ShoppingCart::Order.destroy_all
Author.destroy_all
Book.destroy_all
Image.destroy_all
Category.destroy_all
ShoppingCart::Coupon.destroy_all
User.destroy_all

User.create(email: 'user@example.com',
            password: 'password',
            password_confirmation: 'password',
            confirmed_at: Time.now.utc,
            admin: true)

3.times do |index|
  ShoppingCart::Delivery.create(title: 'Delivery - test', price: index * 5 + 5,
                days: '3 to 5 days', active: true)
end

5.times do |index|
  category = Category.create!(title: Faker::Book.title)

  ShoppingCart::Coupon.create!(code: "code-#{index}", discount: index + 3)

  10.times do
    book = Book.create(
      title: Faker::Book.title,
      description: "#{Faker::Books::Lovecraft.sentence} We pore through",
      price: rand(5..300),
      width: rand(5..30),
      height: rand(5..30),
      depth: rand(5..30),
      publication_year: rand(1970..2018),
      materials: Faker::Books::Lovecraft.tome,
      quantity: rand(5..50),
      category: category
    )

    Author.create!(
      firstname: Faker::Name.first_name,
      lastname: Faker::Name.last_name,
      description: Faker::Books::Lovecraft.sentence,
      books: [book]
    )
  end
end

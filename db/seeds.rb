Delivery.destroy_all
Order.destroy_all
Author.destroy_all
Book.destroy_all
Image.destroy_all
Category.destroy_all
Coupon.destroy_all
User.destroy_all

3.times do |index|
  Delivery.create(title: 'Delivery - test', price: index * 5, days: '3 to 5 days')
end

10.times do |index|
  category = Category.create(title: "#{index + 1} #{Faker::Book.genre}")

  unless category.valid?
    puts category.errors.full_messages
  end

  coupon = Coupon.create(code: "code-#{index}", discount: index + 3)

  unless coupon.valid?
    puts coupon.errors.full_messages
  end

  10.times do
    book = Book.create(
      title: Faker::Book.title,
      description: "#{Faker::StarWars.wookiee_sentence} We pore through hundreds of new books each month and select the five best we can find to share with our members.",
      price: rand(5..300),
      width: rand(5..30),
      height: rand(5..30),
      depth: rand(5..30),
      publication_year: rand(1970..2018),
      materials: Faker::StarWars.planet,
      quantity: rand(5..50),
      category: category)
        
    unless book.valid?
      puts book.errors.full_messages
    end
  
    author = Author.create(
      firstname: Faker::Name.first_name,
      lastname: Faker::Name.last_name,
      description: Faker::StarWars.wookiee_sentence,
      books: [book])
  end
end
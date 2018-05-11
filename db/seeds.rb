# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Order.destroy_all
# order = Order.create()
# order.addresses.create(firstname: 'firstname', lastname: 'lastname', address: 'address',
# city: 'city', zipcode: 'zipcode', country: 'country', phone: 'phone', 
# address_type: :billing)

Delivery.destroy_all
Order.destroy_all
Author.destroy_all
Book.destroy_all
Image.destroy_all
Category.destroy_all
Coupon.destroy_all

3.times do |index|
  Delivery.create(title: 'Delivery - test', price: index * 5, days: '3 to 5 days')
end
     
2.times do
  order = Order.new
  order.tracking_number = "R#{Time.now.strftime('%d%m%y%H%M%S')}"
  order.save

  order1 = Order.new
  order1.tracking_number = "R#{Time.now.strftime('%d%m%y%H%M%S')}"
  order1.state = 'in_delivery'
  order1.save

  order2 = Order.new
  order2.tracking_number = "R#{Time.now.strftime('%d%m%y%H%M%S')}"
  order2.state = 'delivered'
  order2.save

  order3 = Order.new
  order3.tracking_number = "R#{Time.now.strftime('%d%m%y%H%M%S')}"
  order3.state = 'in_delivery'
  order3.save

  order4 = Order.new
  order4.tracking_number = "R#{Time.now.strftime('%d%m%y%H%M%S')}"
  order4.state = 'completed'
  order4.save

  order5 = Order.new
  order5.tracking_number = "R#{Time.now.strftime('%d%m%y%H%M%S')}"
  order5.state = 'canceled'
  order5.save
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

    image1 = Image.create(url: 'http://jonathantweedy.com/resources/thumbs/SmashingBook5ResponsiveWebDesign.jpg', book: book)
    image2 = Image.create(url: Faker::Avatar.image, book: book)
    image3 = Image.create(url: Faker::Avatar.image, book: book)
    image4 = Image.create(url: Faker::Avatar.image, book: book)    
        
    author = Author.create(
        firstname: Faker::Name.first_name,
        lastname: Faker::Name.last_name,
        description: Faker::StarWars.wookiee_sentence,
        books: [book])
  end
end
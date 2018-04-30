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

Author.destroy_all
Book.destroy_all
Image.destroy_all

30.times do
  category = Category.create(title: Faker::Book.genre)

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
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


t.string "address", null: false
      t.string "firstname", null: false
      t.string "lastname", null: false
      t.string "country", null: false
      t.string "city", null: false
      t.string "zipcode", null: false
      t.string "phone", null: false
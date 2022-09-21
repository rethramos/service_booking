# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

user = User.create!(first_name: 'User', last_name: 'One', email: 'user-1@example.com',
                    password: 'foobar', password_confirmation: 'foobar')

User.create!(first_name: 'Admin', last_name: 'One', email: 'admin-1@example.com',
             password: 'password', password_confirmation: 'password', admin: true)

barber_shop = user.businesses.create!(
  name: 'RQ Barber Shop',
  timezone: 'Asia/Manila'
)
spa = user.businesses.create!(
  name: 'The Spa'
)

barber_shop.create_address!(
  line_one: 'Blk 1 Lot 2, My Village',
  line_two: 'Brgy. Rose',
  city: 'Biñan',
  province: 'Laguna',
  country: 'Philippines',
  postal_code: 4024
)

BookingStatus.create!(BookingStatus::SERVED)
BookingStatus.create!(BookingStatus::PENDING)
BookingStatus.create!(BookingStatus::CANCELLED)

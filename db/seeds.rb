# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
UserBook.destroy_all
TradeBook.destroy_all
Trade.destroy_all
Book.destroy_all
#...
Book.create(title: 'Green Eggs and Ham', author: 'Dr. Seuss')
Book.create(title: 'Lonesome Dove', author: 'Larry McMurtry')
Book.create(title: 'In Search of Lost Time', author: 'Marcel Proust')
Book.create(title: 'Don Quixote', author: 'Miguel de Cervantes')

User.create(first_name: 'Andrew', last_name: 'Allen', password: '123', password_confirmation: '123', phone_number: '1234567890', address: '[address here]', email: '2@2.w',  image_url: 'app/assets/images/default_profile_image.jpg').user_books.create(book: Book.all[0])

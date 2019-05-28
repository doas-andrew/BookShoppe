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

User.create(first_name: 'Andrew', last_name: 'Allen', email: '2@2.w', password: '123', password_confirmation: '123', phone_number: '1234567890', address: '[address here]', avatar_url: '/app/assets/images/default_avatar.jpg').user_books.create(book: Book.all[0])
User.create(first_name: 'Jaehyun', last_name: 'Park', email: 'jae@test.com', password: '123', password_confirmation: '123', phone_number: '5551234567', address: '[address here]', avatar_url: '../../assets/images/default_avatar.jpg').user_books << [UserBook.create(book: Book.all[2]), UserBook.create(book: Book.all[2]), UserBook.create(book: Book.all[3])]
User.create(first_name: 'Scott', last_name: 'Toney', email: 'scott@test.com', password: '123', password_confirmation: '123', phone_number: '5556782222', address: '[address here]', avatar_url: 'https://i.imgur.com/aO27nat.jpg').user_books << [UserBook.create(book: Book.all[1]), UserBook.create(book: Book.all[3])]

Trade.create(sender: User.all[0], recipient: User.all[1], status: 'pending').trade_books << [TradeBook.create(user_book: UserBook.all[0]), TradeBook.create(user_book: UserBook.all[1]), TradeBook.create(user_book: UserBook.all[2]), ]

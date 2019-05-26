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
Book.create(title: 'Green Eggs and Hame', author: 'Dr. Seuss')
Book.create(title: 'Lonesome Dove', author: 'Larry McMurtry')

User.create(name: 'Andrew').user_books.create(book: Book.all[0])
User.create(name: 'Scott').user_books.create(book: Book.all[1])

trade = Trade.create(status: 'pending', sender: User.all[0], recipient: User.all[1])
TradeBook.create(trade: trade, user_book: UserBook.all[0])
TradeBook.create(trade: trade, user_book: UserBook.all[1])

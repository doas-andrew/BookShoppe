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

User.create(name: 'Andrew', img_url: 'https://i.imgur.com/aO27nat.jpg').user_books.create(book: Book.all[0])
User.create(name: 'Scott').user_books.create(book: Book.all[1])
User.create(name: 'Jae').user_books << [UserBook.create(book: Book.all[2]), UserBook.create(book: Book.all[3]), UserBook.create(book: Book.all[3])]

Trade.create(status: 'pending', sender: User.all[0], recipient: User.all[1]).trade_books << [TradeBook.create(user_book: UserBook.all[0]), TradeBook.create(user_book: UserBook.all[1])]
Trade.create(status: 'pending', sender: User.all[2], recipient: User.all[0]).trade_books << [TradeBook.create(user_book: UserBook.all[0]),TradeBook.create(user_book: UserBook.all[3]),TradeBook.create(user_book: UserBook.all[4])]


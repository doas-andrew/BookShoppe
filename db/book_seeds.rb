Author.destroy_all
Book.destroy_all
#...
Author.create(name: 'Czeslaw Milosz').books.create(title: 'Unattainable Earth')
brit = User.create(first_name: 'Brit', last_name: 'Butler', username: 'KingCons', email: 'flat@iron.school', password: '123', phone_number: '1230984567', address: '1200 Peachtree Street')

100.times do
	brit.user_books << UserBook.create(book: Book.first)
end

20.times do
	author = Author.create(name: Faker::Book.author)
	rand(5).times do
		author.books.create(title: Faker::Book.title)
	end
end
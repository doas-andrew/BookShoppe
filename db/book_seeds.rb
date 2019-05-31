Author.create(name: 'Czeslaw Milosz').books.create(title: 'Unattainable Earth')

20.times do
	author = Author.create(name: Faker::Book.author)
	rand(3).times do
		author.books.create(title: Faker::Book.title)
	end
end

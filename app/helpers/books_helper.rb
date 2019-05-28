module BooksHelper

	def user_search_count(count)
		if count == 0
			'No one has this book at the moment.'
		elsif count == 1
			'1 user has this book'
		else
			"#{count} users have this book"
		end
	end
end

class User < ApplicationRecord
	has_many :user_books
	has_many :books, through: :user_books

	def inc_trades
		Trade.all.select {|t| t.recipient == self }
	end

	def out_trades
		Trade.all.select {|t| t.sender == self }
	end

	def inventory
		h = {}
		self.books.each { |book|
  		slug = %Q["#{book.title}" by #{book.author}]
  		h[slug] ||= 0
  		h[slug]  += 1
		}
		return h
	end
end

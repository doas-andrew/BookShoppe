class Book < ApplicationRecord
	belongs_to :author
	has_many :user_books
	has_many :trade_books, through: :user_books
	has_many :users, through: :user_books

	validates :title, { presence: true }
	before_save { self.title = self.title.downcase }

	def slug
		%Q["#{self.title.titleize}" by #{self.author.name.titleize}]
	end

	def num_available
		self.user_books.select {|ub| ub.trade_books.reject{|tb| tb.trade.status == 'accepted' }.any? || ub.trade_books.count == 0 }.map(&:user).uniq
		# byebug
	end
end
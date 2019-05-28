class Book < ApplicationRecord
	belongs_to :author
	has_many :user_books
	has_many :users, through: :user_books

	validates :title, { presence: true,
  										length: {maximum: 50}
  									}
	before_save { self.title = self.title.downcase }

	def slug
		%Q["#{self.title.titleize}" by #{self.author.name.titleize}]
	end
end

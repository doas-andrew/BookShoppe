class Author < ApplicationRecord
	has_many :books

	validates :name, { presence: true }
	before_save { self.name = self.name.downcase }
end

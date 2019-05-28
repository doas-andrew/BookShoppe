class Author < ApplicationRecord
	has_many :books

	validates :name, { presence: true,
  									 length: {maximum: 50}
  								 }
	before_save { self.name = self.name.downcase }
end

class UserBook < ApplicationRecord
	belongs_to :user
	belongs_to :book
	has_many :trade_books
end

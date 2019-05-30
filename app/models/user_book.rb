class UserBook < ApplicationRecord
	belongs_to :user
	belongs_to :book
	has_many :trade_books
	has_many :trades, through: :trade_books
end

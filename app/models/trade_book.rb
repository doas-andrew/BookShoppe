class TradeBook < ApplicationRecord
	belongs_to :user_book
	belongs_to :trade
end

class UserBook < ApplicationRecord
	belongs_to :user
	belongs_to :book
	has_many :trade_books
	has_many :trades, through: :trade_books

	# returns TRUE if the UserBook is NOT involved in any accepted Trades
	def available?
		if self.trades.count == 0
			true
		elsif self.trades.count == 1
			self.trades.first.status == 'pending'
		else
			self.trades.reject{|trade| trade.status == 'accepted' }.any?
		end
	end
end

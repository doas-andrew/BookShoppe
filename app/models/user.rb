class User < ApplicationRecord
	has_many :user_books
	has_many :books, through: :user_books

	VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
	has_secure_password
    before_save { self.email = email.downcase }
    validates :first_name, presence: true, length: {maximum: 50}
    validates :last_name, presence: true, length: {maximum: 50}
    validates :email, presence: true, length: {maximum: 225},
                      format: {with: VALID_EMAIL_REGEX},
                      uniqueness: {case_sensitive: false}

	def to_s
		first_name + " " + last_name
	end

	def inc_trades
		Trade.all.select {|t| t.recipient == self }
	end

	def out_trades
		Trade.all.select {|t| t.sender == self }
	end

	def completed_trades
		Trade.all.select {|t| (t.sender == self || t.recipient == self) &&  t.status == 'completed'}
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

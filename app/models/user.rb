class User < ApplicationRecord
	mount_uploader :image, ImageUploader
	has_secure_password

	has_many :user_books
	has_many :books, through: :user_books

	EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
	PHONE_REGEX = /\d{3}[-.\ ]\d{3}[-.\ ]\d{4}|\d{10}/

  before_save {[ self.email      = self.email.downcase,
  							 self.first_name = self.first_name.capitalize,
  							 self.last_name  = self.last_name.capitalize
  						]}

  validates :first_name,   { presence: true,
  												   length: {maximum: 50}
  											   }
  validates :last_name,    { presence: true,
    											   length: {maximum: 50}
    										   }
  validates :phone_number, { presence: true,
    												 format: {with: PHONE_REGEX}
    											 }
  validates :email,        { presence: true,
                             uniqueness: {case_sensitive: false},
                     	       format: {with: EMAIL_REGEX},
    									       length: {maximum: 50},
                           }
	def full_name
		[self.first_name, ' ', self.last_name].join
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

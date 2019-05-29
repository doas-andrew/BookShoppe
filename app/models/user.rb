class User < ApplicationRecord

	has_many :user_books
	has_many :books, through: :user_books

	mount_uploader :avatar, AvatarUploader
	has_secure_password

	EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
	PHONE_REGEX = /\b\d{3}[-.\s]?\d{3}[-.\s]?\d{4}\b/
	DISPLAY_NAME_REGEX = /\A[a-zA-Z0-9_]*\z/i

  before_save {[ self.email        = self.email.downcase,
  							 self.first_name   = self.first_name.capitalize,
  							 self.last_name    = self.last_name.capitalize,
  							 self.phone_number = self.phone_number.gsub(/\-|\.|\s/, ''),
  							 self.display_name = self.username,
  							 self.username     = self.username.downcase
  						]}

  validates :first_name,		{ presence: true,
  												  	length: {maximum: 50}
  													}
  validates :last_name,			{ presence: true,
    											  	length: {maximum: 50}
    												}
  validates :username,			{ presence: true,
  														uniqueness: {case_sensitive: false},
  														format: {with: DISPLAY_NAME_REGEX},
  													}
  validates :email,					{ presence: true,
                            	uniqueness: {case_sensitive: false},
                     	      	format: {with: EMAIL_REGEX},
    									      	length: {maximum: 50},
														}
  validates :phone_number,	{ presence: true,
  														uniqueness: true,
  														format: {with: PHONE_REGEX}
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
  		h[book.slug] ||= 0
  		h[book.slug]  += 1
		}
		return h
	end
end

class User < ApplicationRecord

	has_many :user_books
	has_many :books, through: :user_books

	mount_uploader :avatar, AvatarUploader
	has_secure_password

	EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
	PHONE_REGEX = /\A\d{10}\z/
	DISPLAY_NAME_REGEX = /\A[a-zA-Z0-9_]*\z/i

  before_save {[ self.first_name   = self.first_name.capitalize,
  							 self.last_name    = self.last_name.capitalize,
  							 self.display_name = self.username,
  							 self.username     = self.username.downcase,
  							 self.email        = self.email.downcase
  						]}

  validates :first_name,		{ presence: true,
  												  	length: {maximum: 50}
  													}
  validates :last_name,			{ presence: true,
    											  	length: {maximum: 50}
    												}
  validates :username,			{ presence: true,
  														format: {with: DISPLAY_NAME_REGEX},
  														uniqueness: {case_sensitive: false}
  													}
  validates :email,					{ presence: true,
                     	      	format: {with: EMAIL_REGEX},
                            	uniqueness: {case_sensitive: false},
    									      	length: {maximum: 50}
														}
  validates :phone_number,	{ presence: true,
  														format: {with: PHONE_REGEX},
  														uniqueness: true
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

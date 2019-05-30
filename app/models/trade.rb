class Trade < ApplicationRecord
	belongs_to :sender, class_name: "User"
  belongs_to :recipient,  class_name: "User"

  has_many :trade_books
  has_many :user_books, through: :trade_books
  has_many :books, through: :user_books

  def create_tbs(sender_books={}, recipient_books={})
    sender_books.each { |slug, num|
      count = num.to_i
      self.sender.find_ub_by_slug(slug).each { |ub|
        if count > 0
          self.trade_books << TradeBook.create(user_book_id: ub.id)
          count -= 1
        end
      }
    }
    recipient_books.each { |slug, num|
      count = num.to_i
      self.recipient.find_ub_by_slug(slug).each { |ub|
        if count > 0
          self.trade_books << TradeBook.create(user_book_id: ub.id)
          count -= 1
        end
      }
    }
  end

  def sender_tb
  	self.trade_books.select {|tb| tb.user_book.user == self.sender }
  end

  def sender_ub
  	self.sender_tb.map(&:user_book)
  end

  def sender_books
  	self.sender_ub.map(&:book)
  	self.sender_ub.map {|ub| ub.book}
  end

  def sender_hash
  	h = {}
  	self.sender_books.each { |book|
  		h[book.slug] ||= 0
  		h[book.slug]  += 1
  	}
  	return h
  end

  #...

  def recipient_tb
  	self.trade_books.select {|tb| tb.user_book.user == self.recipient }
  end

  def recipient_ub
  	self.recipient_tb.map(&:user_book)
  end

  def recipient_books
  	self.recipient_ub.map(&:book)
  end

  def recipient_hash
  	h = {}
  	self.recipient_books.each { |book|
  		h[book.slug] ||= 0
  		h[book.slug]  += 1
  	}
  	return h
  end
end

class BooksController < ApplicationController

	def index
		params[:search] ||= ''
		if params[:search] == ''
			@books = Book.all.sort_by{|b| b.title }
		else
			@book = Book.find_by(title: params[:search].downcase)
			@author = Author.find_by(name: params[:search].downcase) if @book == nil
		end
	end

	def new
		@book = Book.new
		@author = Author.new
	end

	def create
		ActiveRecord::Base.transaction do
			@author = Author.find_or_create_by(name: params[:author_name].downcase)
			@book = Book.find_or_create_by(title: params[:book_title].downcase, author: @author)
    	raise ActiveRecord::Rollback if @author.errors.any? || @book.errors.any?
  	end

		if @author.errors.empty? && @book.errors.empty?
			current_user.user_books.create(book: @book)
			redirect_to user_path(current_user)
		else
			render :new
		end
	end
end

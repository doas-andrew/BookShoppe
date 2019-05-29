class BooksController < ApplicationController

	def index
		if params[:search] == '' || params[:search] == nil
			@books = Book.all
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
		@author = Author.find_or_create_by(name: params[:author_name])
		@book = Book.find_or_create_by(title: params[:book_title],author: @author)
		if @author.errors.empty? && @book.errors.empty?
			current_user.user_books.create(book: @book)
			redirect_to user_path(current_user)
		else
			render :new
		end
	end
end

class UsersController < ApplicationController

	def index
		@user = User.all.first
		render 'trades'
	end
end

class UsersController < ApplicationController

	before_action :set_user, only: [:show]

	def index
		@user = User.all.first
		session[:current_user_id] = @user.id
		render 'trades'
	end

	def show
		render 'user_profile'
	end

	private

	def set_user
		@user = User.find(params[:id])
	end
end

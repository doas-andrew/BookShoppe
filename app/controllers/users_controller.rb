class UsersController < ApplicationController

	before_action :set_user, only: [:show]

	def index
		# @user = User.all.first
		# session[:current_user_id] = @user.id
		# render 'trades'
		@users = User.all
	end

	def show
		render 'user_profile'
	end

	def new
    end

    def create
        User.create(first_name: params[:first_name],
                       last_name: params[:last_name],
                       email: params[:email],
                       password: params[:password],
					   password_confirmation: params[:password_confirmation],
					   phone_number: params[:phone_number],
					   address: params[:address],
					   image_url: params[:image_url])
		redirect_to :root
	end

	private

	def set_user
		@user = User.find(params[:id])
	end
end

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
		@user = User.new
  end

  def create
    @user = User.new(create_user_params)
     if @user.save
			redirect_to users_path
		else
			render 'new'
		end
	end

	private

	def create_user_params
		params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :phone_number, :address)
	end

	def set_user
		@user = User.find(params[:id])
	end
end

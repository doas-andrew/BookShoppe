class UsersController < ApplicationController

	before_action :set_user, only: [:show, :show_trades, :edit, :update, :edit_password, :update_password]

	def index
		@users = User.all
	end

	def show
		render :user_profile
	end

	def show_trades
		render :trades
	end

	def new
		@user = User.new
  end

  def create
	@user = User.new(user_params)
     if @user.save
     	log_in(@user)
			redirect_to root_path
		else
			render :new
		end
	end

	def edit
	end

	def update
		if @user.authenticate(params[:user][:password]) && @user.update(user_params)
			redirect_to user_path(@user)
		else
			render :edit
		end 
	end

	def edit_password
		render :change_password
	end

	def update_password
		if @user.update(user_params)
			redirect_to user_path(@user)
		else
			render :change_password
		end 
	end

	private

	def user_params
		params[:user][:phone_number] = params[:user][:phone_number].gsub(/[^0-9]/, '') if params[:user][:phone_number]
		params.require(:user).permit(:first_name, :last_name, :username, :email, :password, :password_confirmation, :phone_number, :address, :avatar)
		# byebug
	end


	def set_user
		@user = User.find(params[:id])
	end
end

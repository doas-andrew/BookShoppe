class UsersController < ApplicationController

	before_action :set_user, only: [:show, :show_trades, :edit, :update]

	def index
		@users = User.all
	end

	def show
		# byebug
		render 'user_profile'
	end

	def show_trades
		render 'trades'
	end

	def new
		@user = User.new
  end

  def create
  	params[:phone_number] = params[:phone_number].gsub(/\-|\.|\s/, '')
    @user = User.new(create_user_params)
     if @user.save
     	login(@user)
			redirect_to users_path
		else
			render 'new'
		end
	end

	def edit
	end

	def update
  	params[:phone_number] = params[:phone_number].gsub(/\-|\.|\s/, '')
		if @user.update(create_user_params)
            redirect_to user_path(@user)
        else 
            render :edit
        end 
	end

	def change_password
	end

	private

	def create_user_params
		params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :phone_number, :address, :avatar)
	end

	def set_user
		@user = User.find(params[:id])
	end
end

class UsersController < ApplicationController

	before_action :set_user, except: [:new, :create]

	def show
		render :user_profile
	end

	def show_trades
		render :user_trades
	end

	def new
		@user = User.new
  end

  def create
  	@user = User.new(user_params)
    if @user.save
     	login(@user)
			redirect_to root_path
		else
			render :new
		end
	end

	def edit
	end

	def update
		if @user.update(user_params)
			redirect_to user_path(@user)
		else
			render :edit
		end 
	end

	def destroy
		@user.all_trades.each(&:destroy)
		@user.trade_books.each(&:destroy)
		@user.user_books.each(&:destroy)
		@user.destroy
		redirect_to root_path
	end

	private

	def user_params
		params[:user][:phone_number].gsub!(/[^0-9]/, '')
		params.require(:user).permit(:first_name, :last_name, :username, :email, :password, :password_confirmation, :phone_number, :address, :avatar)
	end


	def set_user
		@user = User.find(params[:id])
	end
end

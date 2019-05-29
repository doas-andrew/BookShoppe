class SessionsController < ApplicationController

  def index
    if user_signed_in?
      @link1 = new_book_path
      @link2 = user_trades_path(current_user)
      @link3 = user_path(current_user)
      render 'homepage'
    else
      render :new
    end

    # if user_signed_in?
    #   @link1 = new_book_path
    #   @link2 = user_trades_path(current_user)
    #   @link3 = user_path(current_user)
    # else
    #   @link1 = new_user_path
    #   @link2 = new_user_path
    #   @link3 = new_user_path
    # end
    # render 'homepage'
  end

  def new
  end

  def create
    @user   = User.find_by(email: params[:user].downcase)
    @user ||= User.find_by(username: params[:user].downcase)
    @login_failed = false
    if @user && @user.authenticate(params[:password])
      log_in @user
      redirect_to :root
    else
      @login_failed = true
      render 'new'
    end
  end
  
  def destroy
    log_out
    redirect_to :root
  end
end

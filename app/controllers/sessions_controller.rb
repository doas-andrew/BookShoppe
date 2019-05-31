class SessionsController < ApplicationController

  def index
    if user_signed_in?
      render :homepage
    else
      render :new
    end
  end

  def new
  end

  def create
    @user   = User.find_by(email: params[:user].downcase)
    @user ||= User.find_by(login_name: params[:user].downcase)

    if @user && @user.authenticate(params[:password])
      login @user
      redirect_to :root
    else
      session[:login_failed] = true
      render :new
    end
  end
  
  def destroy
    logout
    redirect_to :root
  end
end

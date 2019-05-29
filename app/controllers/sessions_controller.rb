class SessionsController < ApplicationController

  def index
    render 'homepage'
  end

  def new
  end

  def create
    @login_failed = false
    @user = User.find_by(email: params[:user].downcase)
    @user = User.find_by(username: params[:user].downcase)
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

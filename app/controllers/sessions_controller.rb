class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:email].downcase)
    byebug
    @error = false
    if @user && @user.authenticate(params[:password])
      log_in(@user)
      redirect_to :root
    else
      @error = true
      render 'new'
    end
  end
  
  def destroy
    log_out
    redirect_to :root
  end
end

class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email].downcase)
    if user && user.authenticate(params[:password])
      log_in(user)
      redirect_to :root
    else 
      flash[:alert] = "Email Adress or Password is incorrect"
      render 'new'

    end
  end
  
  def destroy
    log_out
    redirect_to :root
  end
end

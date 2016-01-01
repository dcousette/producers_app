class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome back, #{user.username}!"
      redirect_to user_path(user)
    else
      flash[:danger] = "Please re-enter your username and password!"
      redirect_to signin_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You have logged out successfully"
    redirect_to signin_path
  end
end

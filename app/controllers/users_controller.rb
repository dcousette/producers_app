class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(username: params[:user][:username], email: params[:user][:email])

    if user.save
      flash[:success] = "Your new user has been created."
      redirect_to users_path
    else
      flash[:danger] = "Please retry"
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])

    if user.update(username: params[:user][:username], email: params[:user][:email])
      flash[:success] = "Your profile has been updated"
      redirect_to user
    else
      flash[:danger] = "Invalid Submission. Please submit acceptable details."
      redirect_to edit_user_path(user)
    end
  end
end

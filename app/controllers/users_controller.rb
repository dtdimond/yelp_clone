class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user].permit(:email, :full_name, :password))

    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "You've successfully registered and are now logged in. Welcome!"
      redirect_to home_path
    else
      flash[:danger] = "Oops, there were some problems."
      render :new
    end
  end
end
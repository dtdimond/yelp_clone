class SessionsController < ApplicationController
  def new
    redirect_to home_path if logged_in?
    @user = User.new #for bootstrap_form_for usage
  end

  def create
    user = User.find_by(email: params[:user][:email])
    if user && user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, you're logged in!"
      redirect_to home_path
    else
      flash[:danger] = "There was something wrong with your password or username."
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You've logged out."
    redirect_to root_path
  end
end
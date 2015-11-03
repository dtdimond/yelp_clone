class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create

    redirect_to home_path
  end
end
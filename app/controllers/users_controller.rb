class UsersController < ApplicationController



  def new
    @user = User.new
  end

  def create
    # render json: user_params
    user = User.new user_params
    user.save
    # correct email / password
    session[:user_id] = user.id
    flash[:success] = 'You are now logged in.'
    redirect_to root_path
  end

   private

  def user_params
    params.require(:user).permit(:email,:password,:name, :astro_sign)
  end


end

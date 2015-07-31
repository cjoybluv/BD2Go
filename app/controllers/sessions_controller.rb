class SessionsController < ApplicationController


  # login form
  def new
    # render plain: "new session"
  end

  # login action (create a session)
  def create
    # render plain: "create session"
    # render json: params
    # return
    user = User.authenticate(params[:user][:email],params[:user][:password])
    if user
      # correct email / password
      session[:user_id] = user.id
      # flash[:success] = 'You are now logged in.'
      redirect_to root_path
    else
      # wrong email or password
      flash[:danger] = 'Invalid email or password.'
      redirect_to login_path
      # render :new
    end
  end

  # logout action (invalidates the session)
  def destroy
    # render plain: "destroy session"
    session[:user_id] = nil
    session[:when_choice] = nil
    session[:who_choice] = nil
    # flash[:info] = "You are loggged out."
    redirect_to login_path
  end


end

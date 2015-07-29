class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  before_action :current_user, :when_choice

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def is_authenticated?
    unless @current_user
      flash[:danger] = 'ACCESS DENIED!!!!!'
      redirect_to login_path
    end
  end

  def when_choice
    @when_choice ||= session[:when_choice] || "Today"
  end

  def who_choice
    @who_choice ||= session[:who_choice] || "Customer Search"
  end

end

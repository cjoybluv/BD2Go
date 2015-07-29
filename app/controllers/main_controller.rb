class MainController < ApplicationController

  def index
    @customers = []
    @notes = []
    if (session[:user_id])
      @customers = User.find(session[:user_id]).customers

      time = Time.new
      case @when_choice
      when "Today"
        start_date = Date.new(time.year,time.month,time.day)
        end_date = start_date+1
      when "This Week"
        start_date = Date.new(time.year,time.month,time.day)
        end_date = start_date+7
      end
      @notes = User.find(session[:user_id]).notes
       .where("due_date_time >= :start_date AND due_date_time < :end_date",
               {start_date: start_date, end_date: end_date})
       .order("due_date_time ASC")

    end
    gon.customers = @customers
    gon.notes = @notes
  end

  def edit
    # render json: params[:params][:when_choice]
    # @when_choice = params[:params][:when_choice]
    session[:when_choice] = params[:params][:when_choice]
    # render plain: @when_choice
    redirect_to root_path
  end

end

class MainController < ApplicationController

  def index
    @customers = []
    @notes = []
    if (session[:user_id])
      @customers = User.find(session[:user_id]).customers

      time = Time.new
      start_date = Date.new(time.year,time.month,time.day)
      end_date = start_date+7
      @notes = User.find(session[:user_id]).notes
       .where("due_date_time >= :start_date AND due_date_time < :end_date",
               {start_date: start_date, end_date: end_date})
       .order("due_date_time ASC")

    end
    gon.customers = @customers
    gon.notes = @notes
  end


end

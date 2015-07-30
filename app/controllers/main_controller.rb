class MainController < ApplicationController

  def index
    @users = User.all
    @customers = []
    @notes = []
    if (session[:user_id])

      @customers = User.find(session[:user_id]).customers.order(name: :asc)
      @who_choice = session[:who_choice] || "Customer Search"

      if (@who_choice != '' && @who_choice != 'Customer Search')
        if (@who_choice.length == 1)
          @customers = @customers.find_by_sql("SELECT * FROM customers WHERE name ilike '"+@who_choice+"%'")
        else
          @customers = @customers.find_by_sql("SELECT * FROM customers WHERE CONCAT(name,address,contact,email) ilike '%"+@who_choice+"%'");
        end
      end

      time = Time.new
      case @when_choice
      when "Today"
        start_date = Date.new(time.year,time.month,time.day)
        end_date = start_date+1
      when "This Week"
        start_date = Date.new(time.year,time.month,time.day-time.wday)
        end_date = start_date+7
      when "This Month"
        start_date = Date.new(time.year,time.month,1)
        month_ends = [31,28,31,30,31,30,31,31,30,31,30,31]
        end_day = month_ends[time.month-1]
        if (time.month==2 && time.year%4==0)
          end_day = 29
        end
        end_date = Date.new(time.year,time.month,end_day)
      end

      @notes = User.find(session[:user_id]).notes
       .where("(completed IS NULL OR NOT completed) AND due_date_time >= :start_date AND due_date_time < :end_date",
               {start_date: start_date, end_date: end_date})
       .order("due_date_time ASC")

    end
    gon.customers = @customers
    gon.notes = @notes
    gon.joke_doc = ''
  end

  def edit
    # render json: params
    # render json: params[:params][:when_choice]
    # @when_choice = params[:params][:when_choice]
    session[:when_choice] = params[:params][:when_choice] || session[:when_choice]
    session[:who_choice] = params[:params][:who_choice] || session[:who_choice]
    # render plain: @when_choice
    redirect_to root_path
  end

end

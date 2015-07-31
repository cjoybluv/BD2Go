class NotesController < ApplicationController
  def index
  end

  def show
  end

  def new
    # render plain: params[:customer_id]
    @customer = Customer.find(params[:customer_id])
    @note = Note.new
    @note.user_id = session[:user_id]
  end

  def create
    # note = params[:note]
    # task_date = Time.new(note['due_date_time(1i)'].to_i,note['due_date_time(2i)'].to_i,note['due_date_time(3i)'].to_i,0,0,0)
    # render plain: note
    note = params[:note]
    n = Note.new(subject: note[:subject], body: note[:body])
    due_date_time = note[:due_date_time]
    n.completed = false
    if (due_date_time == nil || due_date_time == '')
      n.due_date_time = Time.new(note['due_date_time(1i)'].to_i,note['due_date_time(2i)'].to_i,note['due_date_time(3i)'].to_i,0,0,0)-(7*60*60)
      n.completed = note[:completed]
    else
      n.due_date_time = note[:due_date_time]
    end
    n.customer_id = params[:customer_id]
    n.user_id = session[:user_id]
    n.save
    redirect_to root_path
  end

  def edit
  end

  def update
  end

  def destroy
  end


  def complete
    # render json: params
    n = Note.find(params[:id])
    n.completed = true
    n.save
    redirect_to root_path
  end
end

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
      # n.due_date_time = Time.new(note['due_date_time(1i)'].to_i,note['due_date_time(2i)'].to_i,note['due_date_time(3i)'].to_i,0,0,0)-(7*60*60)
      n.due_date_time = Time.local(note['due_date_time(1i)'].to_i,note['due_date_time(2i)'].to_i,note['due_date_time(3i)'].to_i,0,0,0)-(7*60*60)
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
    # render json: params
    @customer = Customer.find(Note.find(params[:id]).customer_id)
    @note = Note.find(params[:id])
    if (@note.due_date_time != '')
      if (@note.due_date_time.hour==0 && @note.due_date_time.min==0)
        gon.note_type = 'task'
      else
        gon.note_type = 'appt'
      end
    else
      gon.note_type = 'note'
    end
  end

  def update
    # render json: params[:note]
    note = params[:note]
    n = Note.find params[:id]
    n.subject = note[:subject]
    n.body = note[:body]
    n.completed = note[:completed]
    n.due_date_time = note[:due_date_time]
    if (n.due_date_time.hour == 0 && n.due_date_time.min == 0)
      n.due_date_time = Time.new(note['due_date_time(1i)'].to_i,note['due_date_time(2i)'].to_i,note['due_date_time(3i)'].to_i,0,0,0)-(7*60*60)
    end
    n.save
    redirect_to root_path
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

  private

  def note_params
    # params[:note].require(:subject).permit(:body, :customer_id, :due_date_time, :completed, :user_id)
  end

end


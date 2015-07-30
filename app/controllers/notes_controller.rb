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
    # render json: params
    n = Note.new(subject: params[:note][:subject], body: params[:note][:body])
    n.due_date_time = params[:note][:due_date_time]
    n.completed = params[:note][:completed]
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
    render json: params
  end
end

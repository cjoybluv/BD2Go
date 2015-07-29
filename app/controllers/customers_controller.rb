class CustomersController < ApplicationController
  def index
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def note
    # render json: params
    # render plain: params[:id]
    @customer = Customer.find(params[:id])
    @notes = @customer.notes
  end
end

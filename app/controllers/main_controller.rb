class MainController < ApplicationController

  def index
    gon.customers = User.find(3).customers
  end


end

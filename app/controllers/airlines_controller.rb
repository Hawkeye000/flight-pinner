class AirlinesController < ApplicationController

  def show
    @airline = Airline.find(params[:id])
  end

  def index
    @airlines = Airline.all.page params[:page]
  end

end

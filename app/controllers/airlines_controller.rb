class AirlinesController < ApplicationController

  def show
    @airline = Airline.find(params[:id])
  end

  def index
    @airlines = Airline.where("routes_count > 0").page params[:page]
  end

end

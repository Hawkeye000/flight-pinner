class AirlinesController < ApplicationController

  def show
    @airline = Airline.find(params[:id])
  end

  def index
    @airlines = Airline.where("routes_count > 0").order(params[:sort]).page params[:page]
  end

end

class AirlinesController < ApplicationController

  helper_method :sort_column, :sort_direction

  def show
    @airline = Airline.find(params[:id])
  end

  def index
    @airlines = Airline.where("routes_count > 0").
        order(sort_column.to_s + " " + sort_direction.to_s).
        page params[:page]
  end

  private

    def sort_column
      params[:sort] || :name
    end

    def sort_direction
      params[:direction] || "asc"
    end

end

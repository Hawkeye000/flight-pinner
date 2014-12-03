class AirportsController < ApplicationController

  def index
    @airports = Airport.all
    @hash = Gmaps4rails.build_markers(@airports) do |airport, marker|
      marker.lat airport.latitude
      marker.lng airport.longitude
    end
  end

end

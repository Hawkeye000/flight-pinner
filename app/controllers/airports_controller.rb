class AirportsController < ApplicationController

  def index
    @airports = Airport.all
    @hash = Gmaps4rails.build_markers(@airports) do |airport, marker|
      marker.lat airport.latitude
      marker.lng airport.longitude
      marker.picture({
        url:"/assets/airplane21.png",
        width:"24",
        height:"24"
      })
    end
  end

end

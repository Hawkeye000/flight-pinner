class AirportsController < ApplicationController

  def index
    @airports = Airport.all
    @hash = Gmaps4rails.build_markers(@airports) do |airport, marker|
      marker.lat airport.latitude
      marker.lng airport.longitude
      marker.picture({
          url:"/assets/airplane21.png",
          width:"50",
          height:"50"
      })
      marker.infowindow render_to_string(partial:'mapinfo',
          locals:{airport:airport}).gsub(/\n/, '').gsub(/"/,'\"')
    end
  end

  def show
    @airport = Airport.find(params[:id])
    @hash = Gmaps4rails.build_markers([@airport]) do |airport, marker|
      marker.lat airport.latitude
      marker.lng airport.longitude
      marker.picture({
          url:"/assets/airplane21.png",
          width:"50",
          height:"50"
      })
      marker.infowindow render_to_string(partial:'mapinfo',
          locals:{airport:airport}).gsub(/\n/, '').gsub(/"/,'\"')
    end
  end

end

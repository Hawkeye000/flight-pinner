class RoutesController < ApplicationController

  def index
    if params[:airport_id]
      @airport = Airport.find(params[:airport_id])
      @routes = Airport.find(@airport).departing_flights
      @airports = Gmaps4rails.build_markers([@airport]) do |airport, marker|
        marker.lat airport.latitude
        marker.lng airport.longitude
        marker.picture({
          url:"/assets/airplane21.png",
          width:"32",
          height:"32",
          anchor:["12", "12"]
          })
          marker.infowindow render_to_string(partial:'shared/mapinfo',
          locals:{airport:airport}).gsub(/\n/, '').gsub(/"/,'\"')
        end
      @polylines = @routes.map { |x| x.map_line }
    end
  end

  def show
    @route = Route.find(params[:id])
    @airports = Gmaps4rails.build_markers(@route.airports) do |airport, marker|
      marker.lat airport.latitude
      marker.lng airport.longitude
      marker.picture({
        url:"/assets/airplane21.png",
        width:"32",
        height:"32",
        anchor:["12", "12"]
        })
        marker.infowindow render_to_string(partial:'shared/mapinfo',
        locals:{airport:airport}).gsub(/\n/, '').gsub(/"/,'\"')
    end
    @polylines = [@route.map_line]

  end

end

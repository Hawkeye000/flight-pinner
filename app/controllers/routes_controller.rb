class RoutesController < ApplicationController

  def index
    if params[:airport_id]
      airports = Airport.find(params[:airport_id])
      @routes = Airport.find(params[:airport_id]).departing_flights.page params[:page]
    elsif params[:airline_id]
      # airports = Airline.find(params[:airline_id]).airports
      @routes = Airline.find(params[:airline_id]).routes.
          includes(:origin_airport, :destination_airport).page params[:page]
      airports = @routes.map { |x| x.origin_airport }
      airports += @routes.map { |x| x.destination_airport }
    end
    @airports = Gmaps4rails.build_markers([*airports]) do |airport, marker|
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

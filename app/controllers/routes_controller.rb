class RoutesController < ApplicationController

  def index

    if params[:airport_id]
      airports = Airport.find(params[:airport_id])
      @routes = Airport.find(params[:airport_id]).departing_flights
    elsif params[:airline_id]
      # airports = Airline.find(params[:airline_id]).airports
      @routes = Airline.find(params[:airline_id]).routes.
          includes(:origin_airport, :destination_airport)
      airports = @routes.map { |x| x.origin_airport }
      airports += @routes.map { |x| x.destination_airport }
    elsif params[:search]
      origin = Airport.find_by(iata_faa: params[:search][:origin_iata_faa])
      destination = Airport.find_by(iata_faa: params[:search][:destination_iata_faa])
      airline = Airline.find_by(name: params[:search][:airline_name])
      @routes = Route.all
      @routes = @routes.where(origin_airport:origin) unless params[:search][:origin_iata_faa].empty?
      @routes = @routes.where(destination_airport:destination) unless params[:search][:destination_iata_faa].empty?
      @routes = @routes.where(airline:airline) unless params[:search][:airline_name].empty?
      airports = [origin, destination].compact
    end
    @routes = @routes.page params[:page]

    if @routes.empty?
      flash[:alert] = "No Routes Found!"
    else
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
      @polylines = @routes.map { |x| x.map_line } unless @routes.nil?
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

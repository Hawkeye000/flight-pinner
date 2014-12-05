class AirportsController < ApplicationController

  def index
    if params[:iata_faa]
      @airport = Airport.find_by(iata_faa:params[:iata_faa])
      if @airport
        redirect_to @airport
      else
        flash[:alert] = "Invalid IATA/FAA code!"
      end
    end

    @airports = Airport.all
    @hash = Gmaps4rails.build_markers(@airports) do |airport, marker|
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
  end

  def show
    @airport = Airport.find(params[:id])
    @hash = Gmaps4rails.build_markers([@airport]) do |airport, marker|
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
  end

end

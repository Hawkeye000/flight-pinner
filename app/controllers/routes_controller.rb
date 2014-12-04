class RoutesController < ApplicationController

  def index
    @routes = Route.all
  end

  def show
    @route = Route.find(params[:id])
    @airports = Gmaps4rails.build_markers(@route.airports) do |airport, marker|
      marker.lat airport.latitude
      marker.lng airport.longitude
      marker.picture({
        url:"/assets/airplane21.png",
        width:"30",
        height:"30"
        })
        marker.infowindow render_to_string(partial:'shared/mapinfo',
        locals:{airport:airport}).gsub(/\n/, '').gsub(/"/,'\"')
    end

  end

end

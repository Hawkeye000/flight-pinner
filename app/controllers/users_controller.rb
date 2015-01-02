class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @route_users = @user.route_users.order(date: :desc).page(params[:page])
    @airports = Gmaps4rails.build_markers(@user.airports) do |airport, marker|
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
    @polylines = @user.routes.map { |x| x.map_line }
  end

end

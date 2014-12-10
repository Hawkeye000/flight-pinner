class RouteUsersController < ApplicationController

  def new
    @route_user = RouteUser.new(user_id:(current_user.id unless current_user.nil?))
    @route_user.route_id = params[:route_id]
  end

end

class RouteUsersController < ApplicationController

  def new
    @route_user = RouteUser.new
  end

end

class RouteUsersController < ApplicationController

  def new
    @route_user = RouteUser.new(user_id:(current_user.id unless current_user.nil?))
    @route_user.route_id = params[:route_id]
  end

  def create
    if @route_user = RouteUser.create(route_user_params)
      redirect_to root_path
    else
      render :new, alert:"Failed to Log Flight"
    end
  end

  private

    def route_user_params
      params.require(:route_user).permit(:user_id, :route_id, :date)
    end

end

class RouteUsersController < ApplicationController

  def new
    @route_user = RouteUser.new(user_id:(current_user.id unless current_user.nil?))
    @route_user.route_id = params[:route_id]
  end

  def create
    if @route_user = RouteUser.create(route_user_params)
      flash[:notice] = "Flight successfully logged."
      redirect_to @route_user.user
    else
      render :new, alert:"Failed to Log Flight"
    end
  end

  def destroy
    @route_user = RouteUser.find(params[:id])
    @route_user.destroy
    redirect_to @route_user.user
  end

  private

    def route_user_params
      params.require(:route_user).permit(:user_id, :route_id, :date)
    end

end

class RouteUsersController < ApplicationController

  def new
    @route_user = RouteUser.new(user_id:(current_user.id unless current_user.nil?))
    authorize @route_user
    @route_user.route_id = params[:route_id]
  end

  def create
    @route_user = RouteUser.new(route_user_params)
    authorize @route_user
    if @route_user.save
      flash[:notice] = "Flight successfully logged."
      redirect_to @route_user.user
    else
      flash[:alert] = "Failed to Log Flight"
      render :new
    end
  end

  def destroy
    @route_user = RouteUser.find(params[:id])
    authorize @route_user
    @route_user.destroy
    redirect_to @route_user.user
  end

  def edit
    @route_user = RouteUser.find(params[:id])
    authorize @route_user
  end

  def update
    @route_user = RouteUser.new(route_user_params)
    authorize @route_user
    if @route_user.save
      flash[:notice] = "Flight successfully updated."
      redirect_to @route_user.user
    else
      flash[:alert] = "Failed to update flight"
      render :edit
    end
  end

  private

    def route_user_params
      params.require(:route_user).permit(:user_id, :route_id, :date)
    end

end

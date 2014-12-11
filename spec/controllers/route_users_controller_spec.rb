require 'rails_helper'

RSpec.describe RouteUsersController, :type => :controller do

  describe 'GET #new' do

    context "user is not signed in" do
      it "assigns a new route_user to @route_user" do
        get :new
        expect(assigns(:route_user).attributes).to eq(RouteUser.new.attributes)
      end
    end

    it "renders the :new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do

    before do
      @user = create(:user)
      login_as(@user, scope: :user)
    end

    context "with valid attributes" do
      it "saves the new route_user in the database" do
        expect{
          post :create, route_user:attributes_for(:route_user, user_id:@user.id)
        }.to change(RouteUser,:count).by(1)
      end
      it "redirects to the user page" do
        post :create, route_user:attributes_for(:route_user)
        expect(response).to redirect_to RouteUser.first.user
      end
    end

    context "with invalid attributes" do
      it "does not save the new route_user in the database" do
        expect{ post :create, route_user:attributes_for(:invalid_route_user) }.to change(RouteUser,:count).by(0)
      end
      it "re-renders the :new template"
    end

    context "when the user id and current_user do not match" do
      it "does not save the new route_user in the database"
    end
  end

  describe 'DELETE #destroy' do
    before do
      @user = create(:user)
      @route_user = create(:route_user, user_id:@user.id)
    end

    it "deletes the route_user" do
      expect{
        delete :destroy, id: @route_user
      }.to change(RouteUser, :count).by(-1)
    end

    it "redirects to the user page" do
      delete :destroy, id: @route_user
      expect(response).to redirect_to @route_user.user
    end
  end
end

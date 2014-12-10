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
    context "with valid attributes" do
      it "saves the new route_user in the database"
      it "redirects to the user page"
    end

    context "with invalid attributes" do
      it "does not save the new route_user in the database"
      it "re-renders the :new template"
    end

    context "when the user id and current_user do not match" do
      it "does not save the new route_user in the database"
    end
  end
end

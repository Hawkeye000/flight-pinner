require 'rails_helper'

RSpec.describe RouteUsersController, :type => :controller do

  describe 'GET #new' do
    it "assigns a new route_user to @route_user"
    it "renders the :new template"
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

require 'rails_helper'

RSpec.describe AirlinesController, :type => :controller do

  describe "GET #index" do

    it "populates an array of airlines with routes_count > 0" do
      create(:airline)
      create(:airport, iata_faa:"JFK")
      create(:airport, iata_faa:"BOS")
      create(:route, airline:Airline.first)
      airline = Airline.first
      get :index
      expect(assigns(:airlines)).to match_array([airline])
    end

    it "renders the :index view" do
      get :index
      expect(response).to render_template :index
    end

  end

  describe 'GET #show' do

    it "assigns the requested airline to @airline" do
      airline = create(:airline)
      get :show, id: airline
      expect(assigns(:airline)).to eq(airline)
    end

    it "renders the :show template" do
      get :show, id: create(:airline)
      expect(response).to render_template :show
    end

  end

end

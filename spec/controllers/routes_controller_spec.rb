require 'rails_helper'

RSpec.describe RoutesController, :type => :controller do

  before do
    origin = create(:airport, iata_faa:"BOS")
    destination = create(:airport, iata_faa:"JFK")
    airline = create(:airline)
  end

  describe 'GET #index' do

    it 'populates an array of all routes' do
      route = create(:route)
      get :index, airport_id:1
      expect(assigns(:routes)).to eq([route])
    end

    it 'renders the :index view' do
      get :index, airport_id:1
      expect(response).to render_template :index
    end

  end

  describe 'GET #show' do

    it 'assigns the requested route to @route' do
      route = create(:route)
      get :show, id: route
      expect(assigns(:route)).to eq(route)
    end

    it 'renders the :show template' do
      get :show, id:create(:route)
      expect(response).to render_template :show
    end

  end

end

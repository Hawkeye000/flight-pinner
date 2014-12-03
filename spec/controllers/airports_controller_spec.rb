require 'rails_helper'

RSpec.describe AirportsController, :type => :controller do

  describe 'GET #index' do

    it 'populates an array of all airports' do
      airport = create(:airport)
      get :index
      expect(assigns(:airports)).to eq([airport])
    end

    it 'renders the :index view' do
      get :index
      expect(response).to render_template :index
    end

  end

  describe 'GET #show' do

    it 'assigns the requested airport to @airport' do
      airport = create(:airport)
      get :show, id: airport
      expect(assigns(:airport)).to eq(airport)
    end

    it 'renders the :show template' do
      get :show, id:create(:airport)
      expect(response).to render_template :show
    end

  end

end

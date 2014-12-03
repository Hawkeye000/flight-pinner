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

end

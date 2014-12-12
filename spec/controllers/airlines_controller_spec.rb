require 'rails_helper'

RSpec.describe AirlinesController, :type => :controller do

  describe "GET #index" do

    it "populates an array of airlines" do
      airline = create(:airline)
      get :index
      expect(assigns(:airlines)).to eq([airline])
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

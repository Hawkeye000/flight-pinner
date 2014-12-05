require 'rails_helper'

RSpec.describe User, :type => :model do


  it { should have_many(:routes).through :route_users }
  it { should have_many(:destination_airports).through :routes }
  it { should have_many(:origin_airports).through :routes }
  it { should have_many(:airlines).through :routes }

  describe "#airports" do
    it "should return unique destination and origin airports" do
      @user = create(:user)
      @airline = create(:airline)
      @airport_1 = create(:airport, iata_faa:"JFK")
      @airport_2 = create(:airport, iata_faa:"BOS")
      @user.routes << create(:route)
      expect(@user.airports).to match_array([@airport_1, @airport_2])
    end
  end

end

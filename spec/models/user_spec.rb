require 'rails_helper'

RSpec.describe User, :type => :model do


  it { should have_many(:routes).through :route_users }
  it { should have_many(:destination_airports).through :routes }
  it { should have_many(:origin_airports).through :routes }
  it { should have_many(:airlines).through :routes }

  describe "functions" do

    before do
      @user = create(:user)
      @airline = create(:airline)
      @airport_1 = create(:airport, iata_faa:"JFK", country:"USA")
      @airport_2 = create(:airport, iata_faa:"BOS", country:"USA")
      @airport_1.geocode
      @airport_1.save!
      @airport_2.geocode
      @airport_2.save!
      @route = create(:route)
      create(:route_user, route_id:@route.id, user_id:@user.id)
    end

    describe "#airports" do
      it "should return unique destination and origin airports" do
        expect(@user.airports).to match_array([@airport_1, @airport_2])
      end
    end

    describe "#miles" do
      it "should return the total miles flown by the user" do
        create(:route_user, route_id:@route.id, user_id:@user.id)
        expect(@user.miles).to be_within(1).of(@route.distance*2)
      end
    end

    describe "countries visited" do

      before { create(:route_user, route_id:@route.id, user_id:@user.id) }

      describe "#countries" do

        it "should return an array including all of the country names" do
          expect(@user.countries).to include("USA")
        end

        it "should return only unique values" do
          expect(@user.countries).to_not eq(["USA", "USA", "USA", "USA"])
          expect(@user.countries.length).to eq(1)
        end

      end
    end

  end

end

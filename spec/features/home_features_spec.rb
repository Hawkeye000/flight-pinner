require 'rails_helper'

describe "Home Page" do

  before { visit root_path }

  context "user not signed in" do
    it "should have a link to sign up" do
      expect(page).to have_link("Sign up", href:new_user_registration_path)
    end
  end

  it "should have a link to Login" do
    expect(page).to have_link("Login", href:new_user_session_path)
  end

  it "should have a link to Airlines" do
    expect(page).to have_link("Airlines", href:airlines_path)
  end

  it "should have a link to Airports" do
    expect(page).to have_link("Airports", href:airports_path)
  end

  describe "searching for a route" do

    before do
      @airline = create(:airline, name:"TestAirline")
      @origin = create(:airport, iata_faa:"BOS")
      @destination = create(:airport, iata_faa:"JFK")
      @route = create(:route, origin_airport:@origin, destination_airport:@destination, airline:@airline)

      login_as create(:user), scope: :user
      visit root_path
    end

    it "should display the routes with matching params" do
      fill_in "search_origin_field", with:"BOS"
      fill_in "search_destination_field", with:"JFK"
      fill_in "search_airline_field", with:"TestAirline"
      click_link_or_button "Search Routes"
      expect(page).to have_content("BOS")
      expect(page).to have_content("JFK")
      expect(page).to have_content("TestAirline")
    end

    context "failed search" do
      it "should display a flash message" do
        fill_in "search_origin_field", with:"BOST"
        fill_in "search_destination_field", with:"JFK"
        fill_in "search_airline_field", with:"TestAirline"
        click_link_or_button "Search Routes"
        expect(page).to have_content("No Routes Found!")
      end

      it "should not display any routes" do
        expect(page).to_not have_content("BOS")
        expect(page).to_not have_content("JFK")
        expect(page).to_not have_content("TestAirline")
      end
    end

    context "empty airline field" do
      it "should display only flights that match the origin and destinations" do
        @airline_2 = create(:airline, name:"Test2Airline")
        @airline_3 = create(:airline, name:"Test3Airline")
        # make a second route to expect in the results
        @route_2 = create(:route, origin_airport:@origin, destination_airport:@destination, airline:@airline_2)
        # swap origin and destination to create a route that wont match
        @route_3 = create(:route, origin_airport:@destination, destination_airport:@origin, airline:@airline_3)
        fill_in "search_origin_field", with:"BOS"
        fill_in "search_destination_field", with:"JFK"
        click_link_or_button "Search Routes"
        expect(page).to have_content("TestAirline")
        expect(page).to have_content("Test2Airline")
        expect(page).to have_content("BOS")
        expect(page).to have_content("JFK")
        expect(page).to_not have_content("Test3Airline")
      end
    end

  end

  after do |example|
    if example.exception != nil
      save_and_open_page
    end
  end

end

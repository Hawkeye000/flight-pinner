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

  describe "searching for a route" do

    before do
      login_as create(:user), scope: :user
      visit root_path
    end

    it "should display the routes with matching params" do
      airline = create(:airline, name:"TestAirline")
      origin = create(:airport, iata_faa:"BOS")
      destination = create(:airport, iata_faa:"JFK")
      route = create(:route, origin_airport:origin, destination_airport:destination, airline:airline)
      fill_in "search_origin_field", with:"BOS"
      fill_in "search_destination_field", with:"JFK"
      fill_in "search_airline_field", with:"TestAirline"
      click_link_or_button "Search Routes"
      expect(page).to have_content("BOS")
      expect(page).to have_content("JFK")
      expect(page).to have_content("TestAirline")
    end
  end

  after do |example|
    if example.exception != nil
      save_and_open_page
    end
  end

end

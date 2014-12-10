require 'rails_helper'

describe "logging a flight to profile" do

  before do
    @origin_airport = create(:airport, iata_faa:"JFK")
    @destination_airport = create(:airport, iata_faa:"BOS")
    @airline = create(:airline)
    @routes = [create(:route), create(:route)]
    @user = create(:user)
    login_as(@user, scope: :user)

    visit '/airports/1/routes'
    click_link_or_button("route_1")
  end

  it "should save the new route_user to the db" do
    click_link_or_button("log_flight")
    expect(page).to have_content("Flight successfully logged.")
  end

  after do |example|
    if example.exception != nil
      save_and_open_page
    end
  end

end

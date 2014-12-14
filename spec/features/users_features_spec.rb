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

describe "user profile view" do

  before do
    @origin_airport = create(:airport, iata_faa:"JFK")
    @destination_airport = create(:airport, iata_faa:"BOS")

    @origin_airport.geocode
    @origin_airport.save!
    @destination_airport.geocode
    @origin_airport.save!

    @airline = create(:airline)
    @routes = [create(:route), create(:route)]
    @user = create(:user)
    login_as(@user, scope: :user)
  end

  it "should have the user's email address" do
    visit user_path(@user)
    expect(page).to have_content(@user.email)
  end

  it "should have any logged routes shown" do
    create(:route_user, user_id:1, route_id:1, date:DateTime.now.to_date)
    visit user_path(@user)
    expect(page).to have_content(@user.routes.first.airline.name)
    expect(page).to have_content(@user.routes.first.origin_airport.iata_faa)
    expect(page).to have_content(@user.routes.first.destination_airport.iata_faa)
  end

  it "should show the total miles flown" do
    create(:route_user, user_id:1, route_id:1, date:DateTime.now.to_date)
    create(:route_user, user_id:1, route_id:1, date:DateTime.now.to_date)
    visit user_path(@user)
    expect(page).to have_content(@user.miles.round)
  end

  it "should have a link to the airports" do
    route_user = create(:route_user, user_id:1, route_id:1, date:DateTime.now.to_date)
    origin = route_user.route.origin_airport
    destination = route_user.route.destination_airport
    visit user_path(@user)
    expect(page).to have_link("#{origin.name}", href:airport_path(origin))
    expect(page).to have_link("#{destination.name}", href:airport_path(destination))
  end

  it "should have a link to the airline" do
    route_user = create(:route_user, user_id:1, route_id:1, date:DateTime.now.to_date)
    airline = route_user.route.airline
    visit user_path(@user)
    expect(page).to have_link("#{airline.name}", href:airline_path(airline))
  end

  describe "destroy links" do
    context "logged in as user" do
      it "should have a link to destroy logged routes" do
        create(:route_user, user_id:1, route_id:1, date:DateTime.now.to_date)
        visit user_path(@user)
        expect(page).to have_link("delete_route_1")
      end
    end
    context "not logged in as user" do
      it "should not have a link to destroy logged routes" do
        create(:route_user, user_id:1, route_id:1, date:DateTime.now.to_date)
        logout(:user)
        visit user_path(@user)
        expect(page).to_not have_link("delete_route_1")
      end
    end
  end

  it "should remove the route from the user by clicking the delete button" do
    create(:route_user, user_id:1, route_id:1, date:DateTime.now.to_date)
    visit user_path(@user)
    airline, origin, destination = @user.routes.first.airline, @user.routes.first.origin_airport, @user.routes.first.destination_airport
    expect(page).to have_content(airline.name)
    expect(page).to have_content(origin.iata_faa)
    expect(page).to have_content(destination.iata_faa)
    click_link_or_button("delete_route_1")
    expect(page).to_not have_content(airline.name)
    expect(page).to_not have_content(origin.iata_faa)
    expect(page).to_not have_content(destination.iata_faa)
  end

  after do |example|
    if example.exception != nil
      save_and_open_page
    end
  end

end

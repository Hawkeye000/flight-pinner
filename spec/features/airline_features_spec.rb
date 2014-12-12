require 'rails_helper'

describe "show view" do

  before do
    @airline = create(:airline)
    visit airline_path(@airline)
  end

  it "should display the airline name" do
    expect(page).to have_content(@airline.name)
  end

  it "should display the airline country" do
    expect(page).to have_content(@airline.country)
  end

  it "should display the airports served as links" do
    airport_1 = create(:airport, iata_faa:"JFK")
    airport_2 = create(:airport, iata_faa:"BOS")
    create(:route, origin_airport:airport_1, destination_airport:airport_2, airline:@airline)
    visit airline_path(@airline)
    expect(page).to have_link(airport_1.name, href:airport_path(airport_1))
    expect(page).to have_link(airport_2.name, href:airport_path(airport_2))
  end

end

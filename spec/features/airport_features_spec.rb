require 'rails_helper'

describe "selecting airport by IATA/FAA code" do

  before do
    @airport = create(:airport, iata_faa:"JFK")
  end

  context "valid" do
    it "returns the airport page" do
      visit airports_path
      fill_in 'iata_faa_search', with: "JFK"
      click_button 'Find'
      expect(current_path).to eq(airport_path @airport)
    end
  end

  context "invalid" do

    before do
      visit airports_path
      fill_in 'iata_faa_search', with: "BOS"
      click_button 'Find'
    end

    it "redirects back to #index" do
      expect(current_path).to eq(airports_path)
    end

    it "updates the flash" do
      expect(page).to have_content("Invalid IATA/FAA code!")
    end

  end
end

describe "flights departing from the airport" do

  before do
    @origin_airport = create(:airport, iata_faa:"JFK")
    @destination_airport = create(:airport, iata_faa:"BOS")
    @airline = create(:airline)
    @routes = [create(:route), create(:route)]
  end

  it "should have a link for viewing the routes that leave" do
    visit '/airports/1'
    expect(page).to have_link("Departing Routes", href:'/airports/1/routes')
  end

  after do |example|
    if example.exception != nil
      save_and_open_page
    end
  end

end

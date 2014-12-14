require 'rails_helper'

describe "views" do

  before do
    @airline = create(:airline)
    @airport_1 = create(:airport, iata_faa:"JFK")
    @airport_2 = create(:airport, iata_faa:"BOS")
    create(:route, origin_airport:@airport_1, destination_airport:@airport_2, airline:@airline)
    @no_fly_airline = create(:airline, name:"No-Fly Airline")
  end

  describe "show view" do

    before { visit airline_path(@airline) }

    it "should display the airline name" do
      expect(page).to have_content(@airline.name)
    end
    it "should display the airline country" do
      expect(page).to have_content(@airline.country)
    end
    it "should display the airports served as links" do
      expect(page).to have_link(@airport_1.name, href:airport_path(@airport_1))
      expect(page).to have_link(@airport_2.name, href:airport_path(@airport_2))
    end
    it "should display the total routes served" do
      airline = Airline.first
      expect(page).to have_content(airline.routes_count)
    end

  end

  describe "index view" do

    before { visit airlines_path }

    it "should display links to airlines with routes associated" do
      expect(page).to have_link(@airline.name, href:airline_path(@airline))
    end
    it "should display the number of routes associated with that airline" do
      @airline.reload
      expect(page).to have_content(@airline.routes_count)
    end
    it "should not display airlines which fly no routes" do
      expect(page).to_not have_content(@no_fly_airline.name)
    end

    describe "sorting by columns" do

      before do
        Airline.destroy_all
        Route.destroy_all
        @airlines = []
        @airlines << create(:airline, name:"A", country:"Z", iata:"HI")
        @airlines << create(:airline, name:"B", country:"Y", iata:"IJ")
        @airlines << create(:airline, name:"C", country:"X", iata:"GH")

        # create routes for each of the airlines
        [0, 1, 2].each do |x|
          x.times { create(:route, origin_airport:@airport_1, destination_airport:@airport_2, airline:@airlines[x]) }
        end

        visit airlines_path
      end

      it "should have a sort-by-name link" do
        expect(page).to have_link("Name", href:airlines_path(sort: :name, direction: "desc"))
      end
      # see default to make sure it is sorted correctly

      it "should have a sort-by-country link" do
        expect(page).to have_link("Country", href:airlines_path(sort: :country, direction: "asc"))
      end
      it "should be able to sort by country" do
        click_link_or_button "sort-by-country"
        expect(page).to have_css("table tr td#airline_country_0", text:"X")
        expect(page).to have_css("table tr td#airline_country_1", text:"Y")
      end

      it "should have a sort-by-total-routes link" do
        expect(page).to have_link("Total Routes", href:airlines_path(sort: :routes_count, direction: "asc"))
      end
      it "should be able to sort by Total Routes" do
        click_link_or_button "sort-by-routes_count"
        expect(page).to have_css("table tr td#airline_routes_count_0", text:"1")
        expect(page).to have_css("table tr td#airline_routes_count_1", text:"2")
      end

      it "should have a sort-by-iata link" do
        expect(page).to have_link("IATA", href:airlines_path(sort: :iata, direction: "asc"))
      end
      it "should be able to sort by IATA code" do
        click_link_or_button "sort-by-iata"
        expect(page).to have_css("table tr td#airline_iata_0", text:"GH")
        expect(page).to have_css("table tr td#airline_iata_1", text:"IJ")
      end

      describe "second click" do
        before { click_link_or_button "sort-by-name" }
        
        it "should reverse the direction when clicked again" do
          expect(page).to have_css("table tr td#airline_name_0", text:"C")
          expect(page).to have_css("table tr td#airline_name_1", text:"B")
        end
        it "should show an indicator of the direction pointing down" do
          expect(page).to have_content("\u25b2")
        end
      end

      describe "default" do
        it "should set name as the default" do
          expect(page).to have_css("table tr td#airline_name_0", text:"B")
          expect(page).to have_css("table tr td#airline_name_1", text:"C")
        end
        it "should show an indicator of the direction pointing down" do
          expect(page).to have_content("\u25bc")
        end
      end

    end

  end

  after do |example|
    if example.exception != nil
      # save_and_open_page
    end
  end

end

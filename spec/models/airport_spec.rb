require 'rails_helper'

RSpec.describe Airport, :type => :model do

  describe "associations" do

    before { @airport = create(:airport) }

    it { should have_many :departing_flights }
    it { should have_many :arriving_flights }
    it { should have_many(:airlines).through(:departing_flights) }
    it { should have_many(:destination_airports).through(:departing_flights) }

  end

  describe "responses" do
    it { should respond_to :timezone }
    it { should respond_to :departing_flights_count }
    it { should respond_to :arriving_flights_count }
  end

  describe "validations" do

    context "presence" do
      it { should validate_presence_of :name }
      it { should_not validate_presence_of :iata_faa }
    end

    context "data format" do

      describe "iata_faa" do

        it "should not allow non-unique entries" do
          @airport = create(:airport, iata_faa:"BOS")
          expect(build(:airport, iata_faa:"BOS")).to_not be_valid
        end

        it "should be a three letter acronym" do
          @airport = build(:airport, iata_faa:"BOS")
          expect(@airport).to be_valid
        end

        it "should be valid even with a number" do
          @airport = build(:airport, iata_faa:"4I7")
          expect(@airport).to be_valid
        end

        it "should not be valid if not a three letter acronym" do
          @airport = build(:airport, iata_faa:"WBOS")
          expect(@airport).to_not be_valid
        end

        it "can be nil" do
          @airport = build(:airport, iata_faa:nil)
          expect(@airport).to be_valid
        end

        it "can have nil latitude and longitude if it has iata_faa" do
          @airport = build(:airport, iata_faa:"BOS", latitude:nil, longitude:nil)
          expect(@airport).to be_valid
        end

        it "cannot have nil latitude and longitude if it has no iata_faa data" do
          @airport = build(:airport, iata_faa:nil, latitude:nil, longitude:nil)
          expect(@airport).to_not be_valid
        end

      end

      describe "icao" do

        it "should be a four letter acronym" do
          @airport = build(:airport, icao:"KBOS")
          expect(@airport).to be_valid
        end

        it "should be valid even with a number" do
          @airport = build(:airport, icao:"KBO1")
          expect(@airport).to be_valid
        end

        it "should not be valid if not a four letter acronym" do
          @airport = build(:airport, icao:"BOS")
          expect(@airport).to_not be_valid
        end

        it 'converts \N to a nil' do
          @airport = build(:airport, icao:'\N')
          @airport.save!
          expect(@airport.icao).to be_blank
        end

      end

      it "can display a timezone" do
        @airport = build(:airport, latitude:40.6413111, longitude:-73.77813909999999)
        expect(@airport.timezone).to eq("America/New_York")
      end

    end

  end

  describe "#busiest" do

    before do
      create(:airport, iata_faa:"BOS")
      create(:airport, iata_faa:"CHI")
      create(:airport, iata_faa:"JFK")
      create(:airport, iata_faa:"SFO")
      create(:airline)
      (1..3).each do |x|
        x.times { create(:route, origin_airport_id:x, destination_airport_id:x+1) }
      end
    end

    it "should return the busiest airport based on departing_flights" do
      expect(Airport.busiest).to eq(Airport.find(3))
    end

    it "should return an array of the busiest 'x' airports" do
      expect(Airport.busiest(2)).to eq([Airport.find(3), Airport.find(2)])
    end

  end

  describe "#coordinates_hash" do
    it "should return a hash for google maps" do
      @airport = create(:airport, latitude:50.0, longitude:55.0)
      expect(@airport.coordinates_hash).to eq({lat:50.0, lng:55.0})
    end
  end

  describe "geocoding" do

    before { @airport = create(:airport, iata_faa:"BOS", latitude:nil, longitude:nil)}

    it "should geocode if no lat-long data" do
      expect(@airport.longitude).to_not be_nil
      # print "#{@airport.latitude}, #{@airport.longitude}"
    end

    it "should reverse geocode to give country and city" do
      expect(@airport.reverse_geocode).to eq(["Boston", "United States"])
    end

    it "should save the attributes to the airport object" do
      @airport.reverse_geocode
      expect(@airport.country).to eq("United States")
      expect(@airport.city).to eq("Boston")
    end

  end

  describe "factories" do
    it "should have a valid factory" do
      expect(build(:airport)).to be_valid
    end

    it "should have an invalid factory" do
      expect(build(:invalid_airport)).to_not be_valid
    end
  end

end

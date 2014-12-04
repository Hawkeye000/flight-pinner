require 'rails_helper'

RSpec.describe Route, :type => :model do

  describe "associations" do
    it { should belong_to :airline }
    it { should belong_to :origin_airport }
    it { should belong_to :destination_airport }
  end

  describe "validations" do
    it { should validate_presence_of :origin_airport_id }
    it { should validate_presence_of :destination_airport_id }
    it { should validate_presence_of :airline_id }
    it { should validate_presence_of :origin_airport }
    it { should validate_presence_of :destination_airport }
    it { should validate_presence_of :airline }
  end

  describe "functions" do

    before do
      create(:airline)
      @origin = create(:airport, latitude:40, longitude:40, iata_faa:"JFK")
      @destination = create(:airport, latitude:50, longitude:50, iata_faa:"BOS")
    end

    describe "responses" do
      it { should respond_to :airline }
      it { should respond_to :origin_airport }
      it { should respond_to :destination_airport }
    end

    describe "coordinates" do
      it "should return the coordinates of the origin and destination airport" do
        @route = create(:route)
        expect(@route.coordinates).to eq([[40, 40],[50, 50]])
      end
    end

    describe "airports" do
      it "should return the origin and destination airports" do
        @route = create(:route)
        expect(@route.airports).to eq([@origin, @destination])
      end
    end

  end

  describe "factories" do

    before do
      @airline = create(:airline)
      @airport1 = create(:airport)
      @airport2 = create(:airport, iata_faa:"JFK", icao:"KJFK")
    end

    it "has a valid factory" do
      @route = build(:route)
      expect(@route).to be_valid
    end

    it "has an invalid factory" do
      @route = build(:invalid_route)
      expect(@route).to_not be_valid
    end

  end

end

require 'rails_helper'

RSpec.describe Airport, :type => :model do

  describe "responses" do
    it { should respond_to :timezone }
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

        it "should not be valid if not a four letter acronym" do
          @airport = build(:airport, icao:"BOS")
          expect(@airport).to_not be_valid
        end

      end

      it "can display a timezone" do
        @airport = build(:airport, latitude:40.6413111, longitude:-73.77813909999999)
        expect(@airport.timezone).to eq("America/New_York")
      end

    end

  end

  describe "geocoding" do
    it "should geocode if no lat-long data" do
      @airport = create(:airport, iata_faa:"JFK", latitude:nil, longitude:nil)
      expect(@airport.latitude).to_not be_nil
      expect(@airport.longitude).to_not be_nil
      # print "#{@airport.latitude}, #{@airport.longitude}"
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

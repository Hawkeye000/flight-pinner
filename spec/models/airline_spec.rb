require 'rails_helper'

RSpec.describe Airline, :type => :model do

  describe "validations" do
    it { should validate_presence_of :name }
  end

  describe "associations" do
    it { should have_many :routes }
  end

  describe "fuctions" do

    describe "responses" do
      it { should respond_to :routes_count }
      it { should respond_to :airports }
    end

    describe "#airports" do
      it "should list all the airports run by this airline" do
        @airports = [create(:airport, iata_faa:"JFK"), create(:airport, iata_faa:"BOS")]
        @airline = create(:airline)
        create(:route, origin_airport:@airports[0], destination_airport:@airports[1], airline:@airline)
        expect(@airline.airports).to match_array(@airports)
      end
    end
  end

  describe "codes" do

    before { @airline = build(:airline) }

    it "is invalid if both are blank" do
      @airline.iata = nil
      @airline.icao = nil
      expect(@airline).to_not be_valid
    end

    it "is valid if icao is filled and iata is blank" do
      @airline.iata = nil
      expect(@airline).to be_valid
    end

    it "is valid if iata is filled and icao is blank" do
      @airline.icao = nil
      expect(@airline).to be_valid
    end

    describe "iata" do

      it "is a two letter code" do
        @airline.iata = "AA"
        expect(@airline).to be_valid
      end

      it "can have a number" do
        @airline.iata = "A1"
        expect(@airline).to be_valid
      end

      it "cannot be three letters" do
        @airline.iata = "AAA"
        expect(@airline).to_not be_valid
      end

      it "should capitalize all before validation" do
        @airline.iata = "aa"
        expect(@airline).to be_valid
      end

      it "should capitalize all before saving" do
        @airline.iata = "aa"
        expect{@airline.save!}.to change{Airline.count}.by(1)
        expect(@airline.iata).to eq("AA")
      end

    end

    describe "icao" do

      it "is a three letter code" do
        @airline.icao = "AAA"
        expect(@airline).to be_valid
      end

      it "cannot have a number" do
        @airline.icao = "A1A"
        expect(@airline).to_not be_valid
      end

      it "cannot be two letters" do
        @airline.icao = "AA"
        expect(@airline).to_not be_valid
      end

      it "should capitalize all before validation" do
        @airline.icao = "aaa"
        expect(@airline).to be_valid
      end

      it "should capitalize all before saving" do
        @airline.icao = "aaa"
        expect{@airline.save!}.to change{Airline.count}.by(1)
        expect(@airline.icao).to eq("AAA")
      end

    end

  end

  describe "data integrity" do

    it "always has capitalized countries" do
      @airline = build(:airline, country:'united states')
      @airline.save!
      expect(@airline.country).to eq("United States")
    end

  end

  describe "factories" do

    it "has a valid factory" do
      expect(build(:airline)).to be_valid
    end

    it "has an invalid facotry" do
      expect(build(:invalid_airline)).to_not be_valid
    end

  end

end

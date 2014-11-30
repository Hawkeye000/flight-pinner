require 'rails_helper'

RSpec.describe Airline, :type => :model do

  it { should validate_presence_of :name }

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

require 'rails_helper'

RSpec.describe Airport, :type => :model do

  describe "validations" do

    context "presence" do
      it { should validate_presence_of :name }
      it { should_not validate_presence_of :iata_faa }
      it { should validate_presence_of :latitude }
      it { should validate_presence_of :longitude }
    end

    context "data fomat" do

      describe "iata_faa" do

        it "should be a three letter acronym" do
          @airport = build(:airport, iata_faa:"BOS")
          expect(@airport).to be_valid
        end

        it "should not be valid if not a three letter acronym" do
          @airport = build(:airport, iata_faa:"WBOS")
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

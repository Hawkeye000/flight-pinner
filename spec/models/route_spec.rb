require 'rails_helper'

RSpec.describe Route, :type => :model do

  describe "responses" do
    it { should respond_to :airline }
    it { should respond_to :origin_airport }
    it { should respond_to :destination_airport }
  end

  describe "associations" do
    it { should belong_to :airline }
    it { should belong_to :origin_airport }
    it { should belong_to :destination_airport }
  end

  describe "validations" do
    it { should validate_presence_of :origin_airport_id }
    it { should validate_presence_of :destination_airport_id }
    it { should validate_presence_of :airline_id }
  end

  describe "factories" do

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

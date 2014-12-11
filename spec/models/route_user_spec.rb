require 'rails_helper'

RSpec.describe RouteUser, :type => :model do

  describe "associations" do
    it { should belong_to :user }
    it { should belong_to :route }
  end

  describe "methods" do
    it { should respond_to :date }
    it { should respond_to :origin_airport }
    it { should respond_to :origin }
    it { should respond_to :destination }
    it { should respond_to :destination_airport }
    it { should respond_to :airline }
  end

  describe "validation" do
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :route_id }
  end

  describe "factories" do
    it "should have a valid factory" do
      expect(build(:route_user)).to be_valid
    end
    it "should have an invalid factory" do
      expect(build(:invalid_route_user)).to be_invalid
    end
  end

end

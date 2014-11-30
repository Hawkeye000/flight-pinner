require 'rails_helper'

RSpec.describe Route, :type => :model do

  describe "responses" do

    it { should respond_to :airline }
    it { should respond_to :origin_airport }
    it { should respond_to :destination_airport }

  end

  describe "relationships" do

    it { should belong_to :airline }
    it { should belong_to :origin_airport }
    it { should belong_to :destination_airport }

  end

end

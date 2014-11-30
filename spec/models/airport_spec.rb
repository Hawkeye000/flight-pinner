require 'rails_helper'

RSpec.describe Airport, :type => :model do

  describe "validations" do

    context "presence" do
      it { should validate_presence_of :name }
      it { should validate_presence_of :iata_faa }
      it { should validate_presence_of :latitude }
      it { should validate_presence_of :longitude }
    end

  end
  
end

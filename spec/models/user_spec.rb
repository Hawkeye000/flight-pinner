require 'rails_helper'

RSpec.describe User, :type => :model do

  it { should have_many(:routes).through :route_users }
  it { should have_many(:destination_airports).through :routes }
  it { should have_many(:origin_airports).through :routes }
  it { should have_many(:airlines).through :routes }

end

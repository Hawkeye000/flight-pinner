require 'rails_helper'

RSpec.describe User, :type => :model do

  it { should have_many(:routes).through :route_users }

end

require 'rails_helper'

RSpec.describe RouteUser, :type => :model do
  it { should belong_to :user }
  it { should belong_to :route }
end

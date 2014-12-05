require 'rails_helper'

RSpec.describe RouteUser, :type => :model do

  describe "associations" do
    it { should belong_to :user }
    it { should belong_to :route }
  end

  describe "methods" do
    it { should respond_to :date }
  end
  
end

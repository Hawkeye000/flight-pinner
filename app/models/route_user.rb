class RouteUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :route

  validates :user_id, presence:true
  validates :route_id, presence:true
end

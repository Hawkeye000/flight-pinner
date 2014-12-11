class RouteUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :route

  validates :user_id, presence:true
  validates :route_id, presence:true

  def airline
    self.route.airline
  end

  def destination_airport
    self.route.destination_airport
  end

  def origin_airport
    self.route.origin_airport
  end

  alias :origin :origin_airport
  alias :destination :destination_airport

end

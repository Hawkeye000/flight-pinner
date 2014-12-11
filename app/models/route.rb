class Route < ActiveRecord::Base

  UNIT_CONV = {mile:1.0, km:1.60934, kilometer:1.60934, nm:0.868976, nautical_mile:0.868976}

  # associations

  belongs_to :destination_airport, class_name:"Airport", counter_cache: :arriving_flights_count
  belongs_to :origin_airport, class_name:"Airport", counter_cache: :departing_flights_count
  belongs_to :airline, counter_cache:true

  has_many :route_users
  has_many :users, through: :route_users

  # validations

  validates :origin_airport_id, presence:true
  validates :destination_airport_id, presence:true
  validates :airline_id, presence:true
  validates :origin_airport, presence:true
  validates :destination_airport, presence:true
  validates :airline, presence:true

  def airports
    [self.origin_airport, self.destination_airport]
  end

  def coordinates
    [self.origin_airport.coordinates, self.destination_airport.coordinates]
  end

  def coordinates_hash
    [self.origin_airport.coordinates_hash, self.destination_airport.coordinates_hash]
  end

  def distance(units=:mile)
    if self.miles.nil?
      UNIT_CONV[units]*self.origin_airport.distance_to(self.destination_airport)
    else
      UNIT_CONV[units]*self.miles
    end
  end

  def distance!
    self.miles = self.origin_airport.distance_to(self.destination_airport)
  end

  alias :map_line :coordinates_hash
  alias :origin :origin_airport
  alias :destination :destination_airport

end

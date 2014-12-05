class Route < ActiveRecord::Base

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

  alias :map_line :coordinates_hash

end

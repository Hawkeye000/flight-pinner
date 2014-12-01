class Route < ActiveRecord::Base

  # associations

  belongs_to :destination_airport, class_name:"Airport", counter_cache: :arriving_flights_count
  belongs_to :origin_airport, class_name:"Airport", counter_cache: :departing_flights_count
  belongs_to :airline, counter_cache:true

  # validations

  validates :origin_airport_id, presence:true
  validates :destination_airport_id, presence:true
  validates :airline_id, presence:true
  validates :origin_airport, presence:true
  validates :destination_airport, presence:true
  validates :airline, presence:true

end

class AddArrivingFlightsCountToAirport < ActiveRecord::Migration
  def up
    add_column :airports, :arriving_flights_count, :integer, null:false, default:0
    # reset caches counts for airlines with flights only
    ids = Set.new
    Route.all.each { |r| ids << r.destination_airport_id }
    ids.each do |destination_airport_id|
      Airport.reset_counters(destination_airport_id, :arriving_flights)
    end
  end

  def self.down
    remove_column :airports, :arriving_flights_count
  end
end

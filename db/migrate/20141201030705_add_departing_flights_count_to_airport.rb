class AddDepartingFlightsCountToAirport < ActiveRecord::Migration
  def up
    add_column :airports, :departing_flights_count, :integer, null:false, default:0
    # reset caches counts for airlines with flights only
    ids = Set.new
    Route.all.each { |r| ids << r.origin_airport_id }
    ids.each do |origin_airport_id|
      Airport.reset_counters(origin_airport_id, :departing_flights)
    end
  end

  def self.down
    remove_column :airports, :departing_flights_count
  end
end

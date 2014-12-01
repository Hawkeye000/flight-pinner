class AddRoutesCountToAirlines < ActiveRecord::Migration
  def up
    add_column :airlines, :routes_count, :integer, null:false, default:0
    # reset caches counts for airlines with flights only
    ids = Set.new
    Route.all.each { |r| ids << r.airline_id }
    ids.each do |airline_id|
      Airline.reset_counters(airline_id, :routes)
    end
  end

  def self.down
    remove_column :airlines, :routes_count
  end
end

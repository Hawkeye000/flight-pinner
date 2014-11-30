class CreateAirlines < ActiveRecord::Migration
  def change
    create_table :airlines do |t|
      t.string :name
      t.string :iata
      t.string :icao
      t.string :callsign
      t.string :country

      t.timestamps
    end
  end
end

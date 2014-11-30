class CreateAirports < ActiveRecord::Migration
  def change
    create_table :airports do |t|
      t.string :name
      t.string :iata_faa
      t.string :icao
      t.float :latitude
      t.float :longitude
      t.float :altitude
      t.float :timezone
      t.string :tz_name

      t.timestamps
    end
  end
end

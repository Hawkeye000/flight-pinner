class AddCityAndCountryToAirport < ActiveRecord::Migration
  def change
    add_column :airports, :country, :string
    add_column :airports, :city, :string
  end
end

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'
require 'factory_girl'
#Dir[Rails.root.join("spec/factories.rb")].each { |f| require f }

airport_csv = CSV.read('db/seed_data/airports.dat',headers:true)

airport_objects = []
inv_airport_objects = []

airport_csv.each_with_index do |airport, index|
  ah = airport.to_h
  new_ao = FactoryGirl.build(:airport,
    name:ah['name'],
    iata_faa:ah['iata_faa'],
    icao:ah['icao'],
    latitude:ah['latitude'],
    longitude:ah['longitude'],
    altitude:ah['altitude'])
  if new_ao.valid?
    airport_objects.push(new_ao)
  else
    inv_airport_objects.push(new_ao)
  end
  $stdout.flush
  print "Valid airports #{airport_objects.length}, Invalid airports #{inv_airport_objects.length}, of #{airport_csv.length} Total\r"
end

print "\nInvalid Airports\n"
inv_airport_objects.each { |x| puts x.name }

print "\nCreating valid airports\n"
airport_objects.each do |x|
  $stdout.flush
  if x.save
    print "Airports Created #{Airport.count}\r"
  else
    print "Error Encountered! Airport:#{x.name}\n"
  end
end

print "Finished creating airports.\n"

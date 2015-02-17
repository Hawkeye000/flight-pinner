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

# Airport Seeding

if Airport.count == 0

  airport_csv = CSV.read('db/seed_data/airports.dat',headers:true)

  airport_objects = []
  inv_airport_objects = []

  airport_csv.each_with_index do |airport, index|
    ah = airport.to_h
    new_ao = FactoryGirl.build(:airport,
      id:ah['airport_id'],
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
  airport_objects.each_slice(500) do |x|
    $stdout.flush
    if Airport.import x, validate:false
      print "Airports Created #{Airport.count}\r"
    else
      print "Error Encountered! Airport:#{x.name}\n"
    end
  end

  print "Finished creating airports.\n"

else

  print "Skipped seeding Airport data.\n"
  print "Airport Data already in database.\n"

end

if Airline.count == 0

  airline_csv = CSV.read('db/seed_data/airlines.dat',headers:true)

  airline_objects = []
  inv_airline_objects = []

  airline_csv.each_with_index do |airline, index|
    ah = airline.to_h
    new_ao = FactoryGirl.build(:airline,
    id:ah['airline_id'],
    name:ah['name'],
    iata:ah['iata'],
    icao:ah['icao'],
    callsign:ah['callsign'],
    country:ah['country'])
    if new_ao.valid?
      airline_objects.push(new_ao)
    else
      inv_airline_objects.push(new_ao)
    end
    $stdout.flush
    print "Valid airlines #{airline_objects.length}, Invalid airlines #{inv_airline_objects.length}, of #{airline_csv.length} Total\r"
  end

  print "\nInvalid Airlines\n"
  inv_airline_objects.each { |x| puts x.name }

  print "\nCreating valid airlines\n"
  airline_objects.each_slice(1000) do |x|
    $stdout.flush
    if Airline.import x, validate:false
      print "Airlines Created #{Airline.count}\r"
    else
      print "Error Encountered! Airline:#{x.name}\n"
    end
  end

  print "Finished creating airlines.\n"

else

  print "Skipped seeding Airline data.\n"
  print "Airline Data already in database.\n"

end

if Route.count == 0

  route_csv = CSV.read('db/seed_data/routes.dat',headers:true)

  route_objects = []
  inv_route_objects = []

  route_csv.each_with_index do |route, index|
    rh = route.to_h
    new_ro = FactoryGirl.build(:route,
    airline_id:rh['airline_id'].to_i,
    origin_airport_id:rh['origin_airport_id'].to_i,
    destination_airport_id:rh['destination_airport_id'].to_i,
    stops:rh['stops'].to_i,
    equipment:rh['equipment']
    )
    if new_ro.airline_id.to_i > 0 && new_ro.origin_airport_id.to_i > 0 && new_ro.destination_airport_id.to_i > 0
      route_objects.push(new_ro)
    else
      inv_route_objects.push(new_ro)
    end
    $stdout.flush
    print "Valid routes #{route_objects.length}, Invalid routes #{inv_route_objects.length}, of #{route_csv.length} Total\r"

    # break if index > 10000
  end

  print "\nInvalid routes\n"
  inv_route_objects.each { |x| puts "Airline ID:#{x.airline_id}, From:#{x.origin_airport_id}, To:#{x.destination_airport_id}\n" }

  print "\nCreating valid routes\n"
  route_objects.each_slice(2500) do |x|
    $stdout.flush
    if Route.import x, validate:false
      print "routes Created #{Route.count}\r"
    else
      print "Error Encountered! #{x.airline_id}, #{x.origin_airport_id}, #{x.destination_airport_id}\n"
    end
  end

  print "Finished creating routes.\n"

else

  print "Skipped seeding route data.\n"
  print "route Data already in database.\n"

end

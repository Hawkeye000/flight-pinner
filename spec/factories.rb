FactoryGirl.define do

  factory :user do

  end

  factory :airport do
    name Faker::Company.name
    iata_faa Faker::Lorem.words(3).map { |x| x.first }.join.upcase!
    icao Faker::Lorem.words(4).map { |x| x.first }.join.upcase!
    latitude Faker::Address.latitude.to_f
    longitude Faker::Address.longitude.to_f
    altitude Faker::Number.decimal(3,2)
  end

  factory :invalid_airport, parent: :airport do
    latitude nil
    longitude nil
    name nil
  end

  factory :airline do
    name Faker::Company.name
    iata Faker::Lorem.words(2).map { |x| x.first }.join.upcase!
    icao Faker::Lorem.words(3).map { |x| x.first }.join.upcase!
    callsign Faker::Lorem.word
    country Faker::Address.country
  end

  factory :invalid_airline, parent: :airline do
    name nil
    iata nil
  end

  factory :route do
    airline_id 1
    origin_airport_id 1
    destination_airport_id 2
    stops 0
    equipment "738"
  end

  factory :invalid_route, parent: :route do
    airline_id nil
    origin_airport_id nil
    destination_airport_id nil
  end

end

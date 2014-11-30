FactoryGirl.define do

  factory :airport do
    name Faker::Company.name
    iata_faa "BOS"
    icao "KBOS"
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
    iata "AA"
    icao "AAA"
    callsign Faker::Lorem.word
    country Faker::Address.country
  end

  factory :invalid_airline, parent: :airline do
    name nil
    iata nil
  end

end

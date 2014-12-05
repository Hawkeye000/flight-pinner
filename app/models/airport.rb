class Airport < ActiveRecord::Base

  #associations

  has_many :departing_flights, foreign_key: :origin_airport_id, class_name: Route
  has_many :arriving_flights, foreign_key: :destination_airport_id, class_name: Route
  has_many :destination_airports, through: :departing_flights, class_name:Airport
  has_many :airlines, -> { uniq }, through: :departing_flights

  #validations

  validates :name, presence:true
  validates :latitude, presence:true, if:"iata_faa.nil?"
  validates :longitude, presence:true, if:"iata_faa.nil?"

  validates :iata_faa, format:
    { with: /\A([A-Z]|\d){3}\z/, message:"must be 3-letter acronym" },
    allow_blank:true
  validates :iata_faa, uniqueness:true

  validates :icao, format:
    { with: /\A([A-Z]|\d){4}\z/, message:"must be 4-letter acronym" },
    allow_blank:true
  before_validation { self.icao = nil if self.icao == '\N' }

  geocoded_by :iata_faa
  after_validation :geocode, if: lambda { |a| a.latitude.nil? || a.longitude.nil? }

  reverse_geocoded_by :latitude, :longitude do |obj, results|
    if geo = results.first
      obj.city, obj_country = geo.city, geo.country
    end
  end

  def self.busiest(num=1)
    x = self.all.order(:departing_flights_count).reverse.first(num)
    x.length == 1 ? x[0] : x
  end

  def coordinates
    [self.latitude, self.longitude]
  end

  def coordinates_hash
    [:lat, :lng].zip(self.coordinates).to_h
  end

  def timezone
    NearestTimeZone.to(self.latitude, self.longitude)
  end

end

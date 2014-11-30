class Airport < ActiveRecord::Base

  #associations

  has_many :departing_flights, foreign_key: :origin_airport_id, class_name: Route
  has_many :arriving_flights, foreign_key: :destination_airport_id, class_name: Route

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

  def timezone
    NearestTimeZone.to(self.latitude, self.longitude)
  end

end

class Airport < ActiveRecord::Base

  validates :name, presence:true
  validates :longitude, presence:true
  validates :latitude, presence:true

  validates :iata_faa, format:
    { with: /\A[A-Z]{3}\z/, message:"must be 3-letter acronym" },
    allow_blank:true
  validates :iata_faa, uniqueness:true

  validates :icao, format:
    { with: /\A[A-Z]{4}\z/, message:"must be 4-letter acronym" }

end

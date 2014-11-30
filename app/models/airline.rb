class Airline < ActiveRecord::Base

  validates :name, presence:true

  validates :iata, presence:true, unless: :one_code?
  validates :icao, presence:true, unless: :one_code?

  validates :iata, format: { with: /\A([A-Z]|\d){2}\z/, message:"must be 2 character alphanumeric" },
    allow_blank:true
  validates :icao, format: { with: /\A[A-Z]{3}\z/, message:"must be 3 character alphabetic" },
    allow_blank:true

  before_save { self.country = self.country.titleize }
  before_validation { self.iata.upcase! unless self.iata.blank? }
  before_validation { self.icao.upcase! unless self.icao.blank? }

  private
    def one_code?
      (!self.iata.blank?) || (!self.icao.blank?)
    end

end

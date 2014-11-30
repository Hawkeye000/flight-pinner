class Airline < ActiveRecord::Base

  validates :name, presence:true

  validates :iata, presence:true, unless: :one_code?
  validates :icao, presence:true, unless: :one_code?

  def one_code?
    (!self.iata.blank?) || (!self.icao.blank?)
  end

end

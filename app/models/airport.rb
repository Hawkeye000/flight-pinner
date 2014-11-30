class Airport < ActiveRecord::Base

  validates :name, presence:true
  validates :iata_faa, presence:true
  validates :longitude, presence:true
  validates :latitude, presence:true

end

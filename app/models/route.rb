class Route < ActiveRecord::Base

  # associations

  belongs_to :destination_airport, class_name:"Airport"
  belongs_to :origin_airport, class_name:"Airport"
  belongs_to :airline

  # validations

  validates :origin_airport_id, presence:true
  validates :destination_airport_id, presence:true
  validates :airline_id, presence:true

end

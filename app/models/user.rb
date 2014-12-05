class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :route_users
  has_many :routes, through: :route_users
  has_many :destination_airports, through: :routes
  has_many :origin_airports, through: :routes
  has_many :airlines, through: :routes

  def airports
    (self.destination_airports + self.origin_airports).uniq
  end
end

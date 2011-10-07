class VehicleDaily < ActiveRecord::Base
  belongs_to :vehicle
  belongs_to :vehicle_historic

  validates :vehicle_id, :km, :date, :presence => true
end
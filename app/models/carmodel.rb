class Carmodel < ActiveRecord::Base
  belongs_to :brand
  
  has_many :vehicles, :dependent => :destroy
  has_many :carmodel_oils, :dependent => :delete_all
  has_many :oils, :through => :carmodel_oils
  
  accepts_nested_attributes_for :carmodel_oils, :reject_if => lambda { |a| a[:km].blank? }, :allow_destroy => true
end
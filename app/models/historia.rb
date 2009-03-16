class Historia < ActiveRecord::Base
  has_many :cambios
  #has_and_belongs_to_many :orden
end

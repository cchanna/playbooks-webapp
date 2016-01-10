class Archetype < ActiveRecord::Base
  validates :name, presence: true 
end

class Character < ActiveRecord::Base
  belongs_to :archetype
  has_many :relationships
  has_many :tools
end

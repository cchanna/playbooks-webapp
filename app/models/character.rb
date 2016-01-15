class Character < ActiveRecord::Base
  belongs_to :archetype
  has_many :relationships
end

class Character < ActiveRecord::Base
  belongs_to :archetype
  has_many :looks
  has_many :def_looks, through: :looks
  has_many :relationships
  has_many :tools
  has_many :moves
  has_many :fates
  has_many :dire_fates
end

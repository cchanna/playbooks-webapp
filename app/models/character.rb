class Character < ActiveRecord::Base
  belongs_to :archetype
  has_many :looks, dependent: :destroy
  has_many :def_looks, through: :looks
  has_many :relationships, dependent: :destroy
  has_many :tools, dependent: :destroy
  has_many :moves, dependent: :destroy
  has_many :fates, dependent: :destroy
  has_many :dire_fates, dependent: :destroy
end

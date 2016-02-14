class Character < ActiveRecord::Base
  belongs_to :archetype
  has_many :looks, dependent: :destroy
  has_many :def_looks, through: :looks
  has_many :relationships, dependent: :destroy
  has_many :moves, dependent: :destroy
  has_many :fates, dependent: :destroy
  has_many :dire_fates, dependent: :destroy

  has_many :tools, dependent: :destroy
  has_one :gift, dependent: :destroy
  has_many :vows, dependent: :destroy
  has_one :spellbook, dependent: :destroy
  has_many :spells, through: :spellbook
end

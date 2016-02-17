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

  # attr_accessible :starting_brave

  def brave
    return starting_brave
  end
  def fierce
    return starting_fierce
  end
  def wary
    return starting_wary
  end
  def clever
    return starting_clever
  end
  def strange
    return starting_strange
  end
end

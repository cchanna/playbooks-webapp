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

  has_many :improvements, dependent: :destroy
  has_many :stat_changes, through: :improvements

  # attr_accessible :starting_brave

  def brave
    return starting_brave + stat_changes.where(stat: "brave").count
  end
  def fierce
    return starting_fierce + stat_changes.where(stat: "fierce").count
  end
  def wary
    return starting_wary + stat_changes.where(stat: "wary").count
  end
  def clever
    return starting_clever + stat_changes.where(stat: "clever").count
  end
  def strange
    return starting_strange + stat_changes.where(stat: "strange").count
  end
end

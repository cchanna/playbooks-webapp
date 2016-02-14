class Spellbook < ActiveRecord::Base
  belongs_to :character
  has_many :spells, dependent: :destroy
end

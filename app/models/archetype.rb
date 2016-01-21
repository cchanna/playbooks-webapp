class Archetype < ActiveRecord::Base
  validates :name, presence: true
  has_many :sample_names
  has_many :name_categories
  has_many :def_looks
  has_many :trust_questions
  has_many :def_moves
end

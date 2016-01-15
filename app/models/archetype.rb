class Archetype < ActiveRecord::Base
  validates :name, presence: true
  has_many :sample_names
  has_many :name_categories
  has_many :trust_questions
end

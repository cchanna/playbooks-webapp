class Archetype < ActiveRecord::Base
  validates :name, presence: true
  has_many :sample_names, dependent: :destroy
  has_many :name_categories, dependent: :destroy
  has_many :def_looks, dependent: :destroy
  has_many :trust_questions, dependent: :destroy
  has_many :def_moves, dependent: :destroy
  has_many :def_fates, dependent: :destroy
  has_many :def_dire_fates, dependent: :destroy
end

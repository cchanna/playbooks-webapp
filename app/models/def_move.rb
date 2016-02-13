class DefMove < ActiveRecord::Base
  belongs_to :archetype
  has_many :def_move_options, dependent: :destroy
  has_many :def_move_fields, dependent: :destroy
  has_many :moves, dependent: :destroy
end

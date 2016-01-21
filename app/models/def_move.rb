class DefMove < ActiveRecord::Base
  belongs_to :archetype
  has_many :def_move_options
end

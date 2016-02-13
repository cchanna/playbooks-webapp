class DefMoveOption < ActiveRecord::Base
  belongs_to :def_move
  has_many :move_options, dependent: :destroy
end

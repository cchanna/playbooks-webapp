class MoveOption < ActiveRecord::Base
  belongs_to :move
  belongs_to :def_move_option
end

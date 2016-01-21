class Move < ActiveRecord::Base
  belongs_to :character
  belongs_to :def_move
end

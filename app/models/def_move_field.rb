class DefMoveField < ActiveRecord::Base
  belongs_to :def_move
  has_many :move_fields, dependent: :destroy
end

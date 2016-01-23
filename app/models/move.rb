class Move < ActiveRecord::Base
  belongs_to :character
  belongs_to :def_move
  has_many :move_fields, dependent: :destroy
  accepts_nested_attributes_for :move_fields
end

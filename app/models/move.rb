class Move < ActiveRecord::Base
  belongs_to :character
  belongs_to :def_move
  belongs_to :improvement
  has_many :move_fields, dependent: :destroy
  has_many :move_options, dependent: :destroy
  accepts_nested_attributes_for :move_fields
end

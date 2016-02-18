class Improvement < ActiveRecord::Base
  belongs_to :character
  belongs_to :def_improvement
  has_one :stat_change
  has_one :move
  has_one :tool
  has_one :vow
  has_one :gift
end

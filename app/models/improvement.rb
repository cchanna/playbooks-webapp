class Improvement < ActiveRecord::Base
  belongs_to :character
  belongs_to :def_improvement
  has_one :stat_change, dependent: :destroy
  has_one :move, dependent: :destroy
  has_one :tool, dependent: :destroy
  has_one :vow, dependent: :destroy
  has_one :gift, dependent: :destroy
end

class Vow < ActiveRecord::Base
  belongs_to :character
  belongs_to :def_vow
  belongs_to :improvement
end

class Fate < ActiveRecord::Base
  belongs_to :character
  belongs_to :def_fate
end

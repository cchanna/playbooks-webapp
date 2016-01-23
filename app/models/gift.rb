class Gift < ActiveRecord::Base
  belongs_to :character
  belongs_to :gift_type
  belongs_to :gift_curse
end

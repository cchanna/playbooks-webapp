class Gift < ActiveRecord::Base
  belongs_to :character
  belongs_to :gift_type, dependent: :destroy
  belongs_to :gift_curse, dependent: :destroy
end

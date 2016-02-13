class DefVow < ActiveRecord::Base
  has_many :vow, dependent: :destroy
end

class DefLook < ActiveRecord::Base
  belongs_to :archetype
  has_many :looks, dependent: :destroy
end

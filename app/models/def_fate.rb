class DefFate < ActiveRecord::Base
  belongs_to :archetype
  has_many :fates, dependent: :destroy
end

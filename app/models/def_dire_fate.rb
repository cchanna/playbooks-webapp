class DefDireFate < ActiveRecord::Base
  belongs_to :archetype
  has_many :dire_fates, dependent: :destroy
end

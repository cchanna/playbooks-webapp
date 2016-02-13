class DefTool < ActiveRecord::Base
  has_many :example_tools, dependent: :destroy
  has_many :tools, dependent: :destroy
end

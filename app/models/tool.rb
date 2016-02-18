class Tool < ActiveRecord::Base
  belongs_to :def_tool
  belongs_to :character
  belongs_to :improvement
  has_one :replaced_by, class_name: "Tool",
                        foreign_key: "replaces"
  belongs_to :replaces, class_name: "Tool"
end

class Relationship < ActiveRecord::Base
  belongs_to :trust_question
  belongs_to :character
end

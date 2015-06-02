class Move < ActiveRecord::Base
	belongs_to :character
	belongs_to :database_move
end
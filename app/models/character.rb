class Character < ActiveRecord::Base
	belongs_to :user
	has_many :moves
	has_many :database_moves, through: :moves
end
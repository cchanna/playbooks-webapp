class DatabaseMove < ActiveRecord::Base
	has_many :database_moves
	has_many :characters, through: :moves
end

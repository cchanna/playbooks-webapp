class Character < ActiveRecord::Base
	belongs_to :user
	has_many :moves
	has_many :database_moves, through: :moves
	has_many :fates
	validates_presence_of :slug

  def to_param
    slug
  end

  def owned_by?(user)
		return (user.id == user_id)
	end

end
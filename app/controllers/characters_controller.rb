class CharactersController < ApplicationController
  

  def show
  	@character = Character.find_by(slug: params[:slug])
  end

  def new
  end

  def create
  end

  def edit
  end

  def destroy
  end

  def update
    @character = Character.find_by(slug: params[:slug])
    @character.update_attributes(character_params)
      # flash[:success] = "Profile updated"
      # redirect_to @character
    # else
      # render 'edit'
    # end
  end

  def minus_experience
    @character = Character.find_by(slug: params[:slug])
    @character.decrement!(:experience) if @character.experience > 0
    respond_to do |f|
      f.js
    end
  end

  def plus_experience
    @character = Character.find_by(slug: params[:slug])
    @character.increment!(:experience) if @character.experience < 5
    respond_to do |f|
      f.js
    end
  end

  private
  	def character_params
      params.require(:character).permit(:experience, :unprepared)
  	end

end

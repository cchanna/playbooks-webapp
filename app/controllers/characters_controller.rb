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

  def toggle_loss
    @character = Character.find_by(slug: params[:slug])
    case params[:loss]
    when "pride"
      @character.toggle!(:pride)
    when "health"
      @character.toggle!(:health)
    when "strength"
      @character.toggle!(:strength)
    when "hope"
      @character.toggle!(:hope)
    when "life"
      @character.toggle!(:life)
    end
    respond_to do |f|
      f.js
    end
  end

  private
  	def character_params
      params.require(:character).permit(:experience, :unprepared, :pride, :health, :strength, :hope, :life)
  	end

end

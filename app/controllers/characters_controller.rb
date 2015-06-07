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

  private
  	def character_params
      params.require(:character).permit(:unprepared)
  	end

end

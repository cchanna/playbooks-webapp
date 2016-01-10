class CharactersController < ApplicationController
  def show
    @character = Character.find(params[:id])
    if (params[:partial])
      render partial: "#{params[:partial]}", locals: {name: @character.name}
    end
  end

  def new
    @character = Character.new
  end

  def create
    byebug
    character = Character.create(character_params)
    redirect_to character
  end

  private
    def character_params
      params.require(:character).permit(:name, :archetype_id)
    end
    # @character = Character.create()
end

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
    character = Character.create(character_params)
    redirect_to [:setting_symbol, character]
  end

  def update
    character = Character.update(character_params)
  end

  def setting_symbol
    @character = Character.find(params[:id])
  end

  def setting_other
    @character = Character.find(params[:id])
  end

  private
    def character_params
      params.require(:character).permit(:name, :archetype_id)
    end
    # @character = Character.create()
end

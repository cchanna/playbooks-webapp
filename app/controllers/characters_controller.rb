class CharactersController < ApplicationController
  def show
    @character = Character.find(params[:id])

    respond_to do |format|
      format.html {render :text => "", :layout => true}
      if (params[:partial])
        format.js {render partial: "#{params[:partial]}", locals: {name: @character.name}}
      else
        format.js
      end
    end
  end

  def new
    @character = Character.new
    respond_to do |format|
      format.html {render :text => "", :layout => true}
      format.js
    end
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
end

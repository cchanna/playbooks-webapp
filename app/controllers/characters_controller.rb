class CharactersController < ApplicationController
  def show
    @character = Character.find(params[:id])
    if (params[:partial])
      render partial: "#{params[:partial]}", locals: {name: @character.name}
    end
  end
end

class CharactersController < ApplicationController
  def show
    @character = Character.find(params[:id])
    respond_to do |format|
      format.html {render :text => "", :layout => true}
      if params[:partial]
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
    @character = Character.create(character_params)
    respond_to do |format|
      format.html {render :text => setting_symbol_character_path(@character.id)}
    end
  end

  def edit
    # byebug
    @character = Character.find(params[:id])
    respond_to do |format|
      format.html {render text: "", layout: true}
      if params[:field]
        format.js {render partial: "edit_#{params[:field]}"}
      else
        format.js {render partial: "edit_#{params[:field]}"}
      end
    end
  end


  def update
    @character = Character.find(params[:id])
    @character.update(character_params)
    respond_to do |format|
      format.html {render :text => character_path(@character.id)}
    end
  end

  def setting_symbol
    @character = Character.find(params[:id])
    respond_to do |format|
      format.html {render :text => "", :layout => true}
      format.js
    end
  end

  def setting_other
    @character = Character.find(params[:id])
    respond_to do |format|
      format.html {render :text => "", :layout => true}
      format.js
    end
  end

  private
    def character_params
      params.require(:character).permit(:name, :archetype_id)
    end
end

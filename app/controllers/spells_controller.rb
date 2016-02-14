class SpellsController < ApplicationController
  def new
    @character = Character.find params[:character_id]
    @spellbook = @character.spellbook
    @spell = Spell.new(spellbook: @spellbook)
    respond_to do |format|
      format.html {render :text => "", :layout => true}
      format.js {render partial: "edit"}
    end
  end

  def create
    @character = Character.find params[:character_id]
    @spellbook = @character.spellbook
    if @spellbook.nil?
      @spellbook = Spellbook.create(character: @character)
    end
    if params[:spell][:name] == ""
      render nothing: true
    else
      @spell = Spell.create(spellbook: @spellbook)
      @spell.update spell_params
      respond_to do |format|
        format.html {render :text => "", :layout => true}
        format.js {render @spell}
      end
    end
  end

  def edit
    @spell = Spell.find params[:id]
    respond_to do |format|
      format.html {render :text => "", :layout => true}
      format.js {render partial: "edit"}
    end
  end

  def update
    @spell = Spell.find params[:id]
    if params[:spell][:name] == ""
      @spell.destroy
      render nothing: true
    else
      @spell.update spell_params
      respond_to do |format|
        format.html {render :text => "", :layout => true}
        format.js {render @spell}
      end
    end
  end



  private
    def spell_params
      params.require(:spell).permit(:name, :dangerous, :dark,
         :time, :attention, :cost, :effects, :spirit)
    end
end

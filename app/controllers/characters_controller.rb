class CharactersController < ApplicationController
  def show
    @character = Character.find(params[:id])
    respond_to do |format|
      format.html {render :text => "", :layout => true}
      format.js
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
    @character.update(
      brave: @character.archetype.brave,
      fierce: @character.archetype.fierce,
      wary: @character.archetype.wary,
      clever: @character.archetype.clever,
      strange: @character.archetype.strange,
      spirit: 2
    )
    @character.archetype.def_dire_fates.each do |ddf|
      DireFate.create(character:@character, def_dire_fate: ddf, checked: false)
    end
    case @character.archetype.name
    when "Hero"
      Gift.create(character: @character)
    when "Scoundrel"
      3.times do
        Tool.create(character: @character)
      end
    when "Witch"
      Spellbook.create(character: @character)
    end
    @character.archetype.def_moves.where(free: true).each do |m|
      Move.create(character: @character, def_move: m)
    end
    while @character.moves.count < @character.archetype.starting_move_count do
      Move.create(character: @character)
    end
    respond_to do |format|
      format.html {render :text => character_path(@character.id)}
    end
  end

  def edit
    @character = Character.find(params[:id])
    respond_to do |format|
      format.html {render text: "", layout: true}
      format.js
    end
  end

  def edit_name
    @character = Character.find(params[:id])
    respond_to do |format|
      format.html {render text: "", layout: true}
      format.js
    end
  end

  def edit_look
    @character = Character.find(params[:id])
    respond_to do |format|
      format.html {render text: "", layout: true}
      format.js
    end
  end

  def edit_moves
    @character = Character.find params[:id]
    @moves = Array.new
    @character.archetype.def_moves.each do |dm|
      move = Move.find_by(character: @character, def_move: dm)
      if move.nil?
        @move = Move.new(character: @character, def_move: dm)
        fields = Array.new
        puts "\n\n#{@move.def_move.def_move_fields.count}\n\n"
        @move.def_move.def_move_fields.each do |dmf|
          puts "\n\nhi\n\n"
          @move.move_fields.build(def_move_field: dmf)
          puts "\n\n#{@move.move_fields}\n\n"
        end
        @moves.push @move
      else
        @moves.push move
      end
    end
    respond_to do |format|
      format.html {render text: "", layout: true}
      format.js
    end
  end

  def edit_vows
    @character = Character.find params[:id]
    @vows = @character.vows
    respond_to do |format|
      format.html {render text: "", layout: true}
      format.js
    end
  end


  def update
    @character = Character.find(params[:id])
    @character.update(character_params)
    respond_to do |format|
      format.html {render :text => character_path(@character.id)}
    end
  end

  def update_look
    @character = Character.find params[:id]
    @character.archetype.def_looks.each do |dl|
      is_current_look = @character.def_looks.exists?(id: dl.id)
      is_new_look = params[:def_look_ids].include?(dl.id.to_s)
      if !is_current_look && is_new_look
        Look.create(character: @character, def_look: dl)
      elsif is_current_look && !is_new_look
        Look.find_by(character: @character, def_look: dl).destroy
      end
    end
    respond_to do |format|
      format.html {render :text => character_path(@character.id)}
    end
  end

  def update_vows
    @character = Character.find params[:id]
    DefVow.all.each do |dv|
      is_current = @character.vows.exists?(def_vow_id: dv.id)
      is_new = params[:def_vow_ids].include?(dv.id.to_s)
      if is_new
        if is_current
          vow = Vow.find_by(character: @character, def_vow: dv)
        else
          vow = Vow.create(character: @character, def_vow: dv)
        end
        if params[:details][dv.id.to_s]
          vow.update(detail: params[:details][dv.id.to_s])
        end
      end
      if is_current && !is_new
        vowVow.find_by(character: @character, def_vow: dv).destroy
      end
    end
    render nothing: true
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
    @character.update(setting: true)
    respond_to do |format|
      format.html {render :text => "", :layout => true}
      format.js
    end
  end

  def increment_spirit
    @character = Character.find params[:id]
    @character.update(spirit: @character.spirit + 1)
    render partial: "increment_spirit"
  end

  def decrement_spirit
    @character = Character.find params[:id]
    if @character.spirit > 0
      @character.update(spirit: @character.spirit - 1)
    end
    render nothing: true
  end

  private
    def character_params
      params.require(:character).permit(:name, :archetype_id, :move_count)
    end
end

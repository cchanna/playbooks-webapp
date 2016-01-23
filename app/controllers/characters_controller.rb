class CharactersController < ApplicationController
  def show
    @character = Character.find(params[:id])
    respond_to do |format|
      format.html {render :text => "", :layout => true}
      if params[:partial] == "relationships/show"
        format.js {render partial: "relationships/show", locals: {relationship: Relationship.find(params[:relationship_id])}}
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
    @character.update(
      move_count: @character.archetype.starting_move_count,
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
    respond_to do |format|
      format.html {render :text => setting_symbol_character_path(@character.id)}
    end
  end

  def edit
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

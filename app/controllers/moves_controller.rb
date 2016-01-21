class MovesController < ApplicationController
  def update
    @move = Move.find params[:id]
    if params[:def_move] || @move.def_move.free
      @move.update(description: params[:description])
    else
      @move.destroy
    end
    render 'nothing: true'
  end

  def create
    @character = Character.find params[:character_id]
    if params[:def_move]
      @move = Move.create(
        character: @character,
        def_move_id: params[:def_move].to_i,
        description: params[:description]
      )
    end
    render nothing: true
  end
end

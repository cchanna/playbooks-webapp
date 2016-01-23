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
    puts params
    if params[:def_move]
      @move = Move.create(
        character: @character,
        def_move_id: params[:def_move].to_i,
        description: params[:description],
      )
      if params[:move]
        params[:move][:move_fields_attributes].values.each do |f|
          MoveField.create(
            move: @move,
            def_move_field_id: f[:def_move_field_id],
            text: f[:text]
          )
        end
        # @move.update(move_fields: params[:move][:move_fields_attributes].values)
      end
    end
    render nothing: true
  end
end

class MoveFieldsController < ApplicationController
  def destroy
    MoveField.find(params[:id]).destroy
    render nothing: true
  end

  def create
    @move = Move.find params[:move_id]
    @move_field = MoveField.create(
      move: @move,
      def_move_field_id: params[:move_field][:def_move_field_id],
      text: params[:move_field][:text]
    )
    render @move_field
  end

  def new
    @move = Move.find params[:move_id]
    @move_field = MoveField.new(
      move: @move,
      def_move_field_id: params[:def_move_field]
    )
    render partial: "new"
  end
end

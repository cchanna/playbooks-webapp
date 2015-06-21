class MovesController < ApplicationController
	def show
    @move = Move.find(params[:id])
  end

  def new
  end

  def create
  end

  def edit
  end

  def destroy
  end

  def update
    @move = Move.find(params[:id])
    @move.update_attributes(move_params)
    respond_to do |f|
      f.js
    end
  end

  def open_text
    @move = Move.find(params[:id])
  end

  private
  	def move_params
      params.require(:move).permit(:description)
  	end
end

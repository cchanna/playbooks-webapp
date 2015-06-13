class FateController < ApplicationController

	def use
    @fate = Fate.find(params[:id])
    @fate.decrement!(:value) if @fate.value > 0
    respond_to do |f|
      f.js
    end
  end

  def plus
  	@fate = Fate.find(params[:id])
  	@fate.increment!(:value)
  	respond_to do |f|
  		f.js
  	end
  end

	private	
  	def fate_params
      params.require(:fate).permit(:name, :value)
  	end
end

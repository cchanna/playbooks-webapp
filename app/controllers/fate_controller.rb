class FateController < ApplicationController

  def new
    @fate = Fate.new
    head 200, content_type: "text/html"
  end

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

  def open_name
    @fate = Fate.find(params[:id])
  end

  def update
    @fate = Fate.find(params[:id])
    @fate.update_attributes(fate_params)
    head 200, content_type: "text/html"
  end

	private	
  	def fate_params
      params.require(:fate).permit(:name, :value)
  	end
end

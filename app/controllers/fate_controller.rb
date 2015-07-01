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

  def destroy
    Fate.find(params[:id]).destroy
    head 200, content_type: "text/html"
  end

  def open_name
    @fate = Fate.find(params[:id])
  end

  def update
    @fate = Fate.find(params[:id])
    if fate_params[:name] == ""
      puts "*\n*\n*\nDESTROY\n*\n*\n*\n"
      @fate.destroy
    else
      @fate.update_attributes(fate_params)
    end
    head 200, content_type: "text/html"
  end

	private	
  	def fate_params
      params.require(:fate).permit(:name, :value)
  	end
end

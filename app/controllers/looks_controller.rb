class LooksController < ApplicationController
  def new
    @character = Character.find params[:character_id]
    @look = Look.new character: @character
    respond_to do |format|
      format.html {render :text => "", :layout => true}
      format.js
    end
  end

end

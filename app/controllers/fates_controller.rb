class FatesController < ApplicationController
  def new
    @character = Character.find params[:character_id]
    @fate = Fate.new(character: @character)
    respond_to do |format|
      format.html {render :text => "", :layout => true}
      format.js
    end
  end

  def edit
    @fate = Fate.find params[:id]
    @character = @fate.character
    respond_to do |format|
      format.html {render :text => "", :layout => true}
      format.js
    end
  end

  def create
    @character = Character.find params[:character_id]
    @fate = Fate.create(
      character: @character,
      def_fate_id: params[:fate][:def_fate_id],
      advancement: 0,
      completed: false
    )
    render nothing: true
  end

  def update
    @fate = Fate.find params[:id]
    @fate.update def_fate_id: params[:fate][:def_fate_id]
    render nothing: true
  end

  def increment
    @fate = Fate.find params[:id]
    if @fate.advancement < 5
      @fate.update(advancement: @fate.advancement + 1)
    end
    render nothing: true
  end

  def decrement
    @fate = Fate.find params[:id]
    if @fate.advancement > 0
      @fate.update(advancement: @fate.advancement - 1)
    end
    render nothing: true
  end

  def complete
    @fate = Fate.find params[:id]
    @fate.update(completed: true)
    render nothing: true
  end

  def uncomplete
    @fate = Fate.find params[:id]
    @fate.update(completed: false)
    render nothing: true
  end
end

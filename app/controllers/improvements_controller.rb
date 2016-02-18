class ImprovementsController < ApplicationController
  def create
    @character = Character.find params[:character_id]
    @improvement = Improvement.create(character: @character)
    render partial: "link", locals: {improvement: @improvement}
  end

  def new
    @character = Character.find params[:character_id]
    @improvement = Improvement.create(character: @character)
    respond_to do |format|
      format.html {render :text => "", :layout => true}
      format.js {render "edit"}
    end
  end

  def edit
    @character = Character.find params[:character_id]
    @improvement = Improvement.find params[:id]
    respond_to do |format|
      format.html {render :text => "", :layout => true}
      format.js
    end
  end

  def update
    @improvement = Improvement.find params[:id]
    @character = @improvement.character
    @improvement.stat_change.delete unless @improvement.stat_change.nil?
    @improvement.update(improvement_params)
    if @improvement.def_improvement.action == "add stat"
      StatChange.create(
        improvement: @improvement,
        stat: @improvement.def_improvement.value
      )
    end
    render partial: "options"
  end

  def destroy
    @improvement = Improvement.find params[:id]
    @improvement.destroy
    render nothing: true
  end

  private
    def improvement_params
      params.require(:improvement).permit(:def_improvement_id)
    end
end

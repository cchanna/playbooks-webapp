class ToolsController < ApplicationController
  def new
    @character = Character.find params[:character_id]
    @tool = Tool.new(character: @character)
    respond_to do |format|
      format.html {render :text => "", :layout => true}
      format.js
    end
  end

  def create
    @character = Character.find params[:character_id]
    params[:def_tool_ids].each do |t|
      def_tool = DefTool.find t.to_i
      Tool.create(character: @character, def_tool: def_tool)
    end
    render nothing: true
  end
end

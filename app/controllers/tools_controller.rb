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
    @tool = Tool.create(
      name: params[:tool][:name],
      def_tool_id: params[:tool][:def_tool_id],
      description: params[:tool][:description],
      character: @character
    )
    respond_to do |format|
      format.js
    end
  end

  def edit
    @tool = Tool.find(params[:id])
    @character = @tool.character
    respond_to do |format|
      format.js
    end
  end

  def update
    tool = Tool.find(params[:id])
    tool.update(update_tool_params)
    @character = tool.character
    @tool = Tool.new(character: @character)
    respond_to do |format|
      format.js {render "new"}
    end
  end

  def destroy
    tool = Tool.find(params[:id])
    @character = tool.character
    tool.destroy
    @tool = Tool.new(character: @character)
    respond_to do |format|
      format.js {render "new"}
    end
  end

  private
    # def create_tool_params
      # params.require(:character, :def_tool, :name, :description)
    def update_tool_params
      params.require(:tool).permit(:name, :description)
    end
end

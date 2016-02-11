class MovesController < ApplicationController
  def update
    @move = Move.find params[:id]
    # byebug
    if params[:move]
      if params[:move][:def_move_id]
        if @move.def_move_id != params[:move][:def_move_id]
          @move.move_options.destroy_all
          @move.move_fields.destroy_all
          @move.update(
            description: nil,
            def_move_id: params[:move][:def_move_id]
          )
        end
      end
    end
    # if params[:def_move] || @move.def_move.free
    #   if params[:move]
    #     @move.update(description: params[:move][:description])
    #   end
    #   if params[:move_options]
    #     options = params[:move_options].collect{|s| s.to_i}
    #   end
    #   @move.def_move.def_move_options.each do |dmf|
    #     if options
    #       selected = options.include?(dmf.id)
    #     end
    #     option = @move.move_options.find_by(def_move_option_id: dmf.id)
    #     if option.nil? && selected
    #       MoveOption.create(
    #         move: @move,
    #         def_move_option: dmf
    #       )
    #     end
    #     if !option.nil? && !selected
    #       option.destroy()
    #     end
    #     # if @move.move_options.exists?(def_move_option_id: dmf.id) && !selected
    #     # end
    #   end
    # else
    #   @move.destroy
    # end
    render nothing: true
  end

  def create
    @character = Character.find params[:character_id]
    puts params
    if params[:def_move]
      @move = Move.create(
        character: @character,
        def_move_id: params[:def_move].to_i,
        # description: params[:description],
      )
      if params[:move]
        @move.update(
          description: params[:move][:description]
        )
        if params[:move][:move_fields_attributes]
          params[:move][:move_fields_attributes].values.each do |f|
            MoveField.create(
              move: @move,
              def_move_field_id: f[:def_move_field_id],
              text: f[:text]
            )
          end
        end
      end
      if params[:move_options]
        options = params[:move_options].collect{|s| s.to_i}
        byebug
        options.each do |o|
          MoveOption.create(
            move: @move,
            def_move_option_id: o
          )
        end
      end
    end
    render nothing: true
  end

  def edit
    @move = Move.find params[:id]
    respond_to do |format|
      format.html {render :text => "", :layout => true}
      format.js
    end
  end
end

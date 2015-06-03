class CharactersController < ApplicationController
  

  def show
  	@character = Character.find_by(slug: params[:slug])
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
    @character = Character.find(params[:id])
    if @character.update_attributes(Character_params)
      flash[:success] = "Profile updated"
      redirect_to @character
    else
      render 'edit'
    end
  end

  private
  	def Character_params
  	end

end

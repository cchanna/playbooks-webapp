class GiftsController < ApplicationController
  def edit
    @gift = Gift.find params[:id]
    respond_to do |format|
      format.html {render :text => "", :layout => true}
      format.js
    end
  end

  def update
    @gift = Gift.find params[:id]
    @gift.update(gift_params)
    render nothing: true
  end

  private
    def gift_params
      params.require(:gift).permit(:gift_type_id, :description, :gift_curse_id, :detail)
    end
end

class DireFatesController < ApplicationController
  def update
    @dire_fate = DireFate.find params[:id]
    @dire_fate.update checked: params[:dire_fate][:checked]
    render nothing: true
  end
end

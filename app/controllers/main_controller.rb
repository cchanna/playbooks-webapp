class MainController < ApplicationController
  def home
    respond_to do |format|
      format.html {render :text => "", :layout => true}
      format.js
    end
  end
end

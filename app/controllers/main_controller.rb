class MainController < ApplicationController
  def home
    respond_to do |format|
      format.html {render :text => "", :layout => true}
      format.js {render "home.html.erb"}
    end
  end
end

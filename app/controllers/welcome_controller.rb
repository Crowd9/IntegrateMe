class WelcomeController < ApplicationController
  def index
    if request.format.html?
      render :layout => false
    else
      head 404
    end
  end
end

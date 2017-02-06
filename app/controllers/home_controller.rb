class HomeController < ApplicationController

  def index
      redirect_to payments_path
  end

end

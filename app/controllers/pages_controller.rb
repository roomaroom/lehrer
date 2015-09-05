class PagesController < ApplicationController

  def home
  end
  
  def login
    redirect_to home_path if user_signed_in?
  end

end

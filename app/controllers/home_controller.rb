class HomeController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:index]
  layout 'home_layout'

  def index
  end
end

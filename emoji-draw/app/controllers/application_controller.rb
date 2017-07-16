class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def index
  	binding.pry
  	render html: 'welcome to emoji draw!'
  end
end

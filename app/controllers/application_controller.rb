class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def hello
    render html: "Grupo F best group"
  end
end

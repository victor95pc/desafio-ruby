class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_path, alert: "Não possui permissão"
  end

  before_action :authenticate_user!
end

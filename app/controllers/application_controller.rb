class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :first_name, :user_name, :company_name, :location, :tel, :url])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :first_name, :user_name, :company_name, :location, :tel, :url])
    end
end

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale

  before_action :configure_permitted_parameters, if: :devise_controller?

  def default_url_options
  { locale: I18n.locale }
  end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :first_name, :user_name, :company_name, :location, :tel, :url])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :first_name, :user_name, :company_name, :location, :tel, :url])
    end

  private

    def set_locale
      locale = params[:locale] || cookies[:locale] || I18n.default_locale
      I18n.locale = locale
      cookies[:locale] = { value: locale, expires: 30.days }
    end

end

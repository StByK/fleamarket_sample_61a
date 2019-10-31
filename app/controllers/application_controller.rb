class ApplicationController < ActionController::Base
  before_action :basic_auth
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :sign_up, keys: [
        :nickname, :first_name, :last_name, :first_name_kana, :last_name_kana,
        :phone_number, :birth_year, :birth_month, :birth_day
      ])
  end

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == '61_mercari_a' && password == '61a'
    end
  end

end

class ApplicationController < ActionController::Base
  # include SessionsHelper
  # include UsersHelper
  # protect_from_forgery with: :exception
  protect_from_forgery with: :exception, prepend: true

  before_action :configure_permitted_parameters, if: :devise_controller?



  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password)}

      devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password)}
    end

  def after_sign_in_path_for(resource)
    user_path(current_user)
  end
  def after_sign_up_path_for(resource)
    user_path(current_user)
  end
end

class ApplicationController < ActionController::Base
  # include SessionsHelper
  # include UsersHelper
  include ChallengesHelper
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?



  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :avatar)}

      devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :password, :current_password, :avatar)}
    end

  def after_sign_in_path_for(resource)
    user_path(current_user)
  end
  def after_sign_up_path_for(resource)
    user_path(current_user)
  end
end

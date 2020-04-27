class Users::DeviseAuthyController < Devise::DeviseAuthyController

  protected
    def after_authy_enabled_path_for(resource)
      user_path(current_user)
    end

    def after_authy_verified_path_for(resource)
      user_path(current_user)
      # root_path
    end

    def after_authy_disabled_path_for(resource)
      user_path(current_user)
      # root_path
    end

    def invalid_resource_path
      new_user_session_path
    end
end

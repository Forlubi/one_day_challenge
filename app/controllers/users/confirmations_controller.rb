class Users::ConfirmationsController < Devise::ConfirmationsController
  def show
    super do
      sign_in(resource) if resource.errors.empty?
    end
  end

  def after_confirmation_path_for(resource_name, resource)
    after_sign_in_path_for(resource)
  end

  protected

    # The path used after resending confirmation instructions.
    def after_resending_confirmation_instructions_path_for(resource_name)
      is_navigational_format? ? new_session_path(resource_name) : '/'
    end

end
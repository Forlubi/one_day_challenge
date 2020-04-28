class Users::RegistrationsController < Devise::RegistrationsController

  def update
    new_params = params.require(:user).permit(:email, :name, :current_password, :password, :password_confirmation, :avatar)
    change_password = true
    if params[:user][:password].blank?
      params[:user].delete("password")
      params[:user].delete("password_confirmation")
      new_params = params.require(:user).permit(:email, :name, :avatar)
      change_password = false
    end

    @user = User.find(current_user.id)
    is_valid = false

    if change_password
      is_valid = @user.update_with_password(new_params)
    else
      is_valid = @user.update_without_password(new_params)
    end

    if is_valid
      set_flash_message :notice, :updated
      sign_in @user, :bypass => true
      redirect_to after_update_path_for(@user)
    else
      render "edit"
    end
  end

  protected

    def after_update_path_for(resource)
      user_path(resource)
    end

    
    # def update_resource(resource, params)
    #   resource.update_without_password(params)
    # end
end

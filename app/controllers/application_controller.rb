class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protect_from_forgery with: :exception

def after_sign_in_path_for(resource)
    flash[:notice] = "Welcome! You have signed up successfully."

    user_path(resource) # ログイン後に遷移するpathを設定
end


def after_sign_out_path_for(resource)
    flash[:notice] = "Signed out successfully."

    root_path # ログアウト後に遷移するpathを設定
end

  protected

  def configure_permitted_parameters

    added_attrs = [ :email, :name,:password,:password_confirmation]
    devise_parameter_sanitizer.permit(:sign_up, keys:  added_attrs)
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name])

  end

end

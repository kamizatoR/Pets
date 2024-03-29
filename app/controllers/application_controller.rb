class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  before_action :configure_permitted_parameters, if: :devise_controller?

  def authenticate_any!
    if admin_signed_in?
        true
    else
        authenticate_end_user!
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :admin
      new_admin_session_path
    else
      root_path
    end
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :last_kana, :first_kana, :display_name])
  end

  def record_not_found
    render plain: "404 Not Found", status: 404
  end

end

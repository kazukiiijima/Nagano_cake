class ApplicationController < ActionController::Base

before_action :configure_permitted_parameters, if: :devise_controller?

protect_from_forgery with: :exception

def after_sign_in_path_for(resource)
    root_path
  end

def after_sign_up_path_for(resource)
    if customer_signed_up?
      customer_path
    else
      root_path
    end
end

def after_sign_out_path_for(resource)
    new_admin_session_path
end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number ])
  end


end

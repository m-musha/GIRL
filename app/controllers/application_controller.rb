class ApplicationController < ActionController::Base

  #ApplicationControllerを継承しているコントローラー内の全てのアクションが実行される前に、before_actionを実行
  before_action :configure_permitted_parameters, if: :devise_controller?

  #adminsのサインイン後のリダイレクト先を設定
  def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.is_a?(Admin)
        admins_genres_path
    else
        root_path
    end
  end

  #サインアウト後のリダイレクト先を設定
  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :customer
        root_path
    elsif resource_or_scope == :admin
        new_admin_session_path
    else
        root_path
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up)
  end
end

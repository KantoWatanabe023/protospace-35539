class ApplicationController < ActionController::Base
  # before_action :authenticate_user!
  # もしdeviseに関するコントローラーの処理であればconfigure_permitted_parametersメソッドを実行する
  before_action :configure_permitted_parameters, if: :devise_controller?

  # deviseにおけるストロングパラメーターみたいな
  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:profile,:occupation,:position])
  end
end

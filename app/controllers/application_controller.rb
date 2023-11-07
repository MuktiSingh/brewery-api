class ApplicationController < ActionController::Base
  before_action :authorize
  helper_method :current_user

  private def check_logged_in
    return unless cookies[:identifier]

    redirect_to root_path, notice: t('notice.application.logged_in')
  end

  private def authorize
    return if current_user

    redirect_to login_path, alert: t('notice.application.login_request')
  end

  def current_user
    @current_user ||= User.find_by_identifier(cookies[:identifier]) if cookies[:identifier]
  end
end

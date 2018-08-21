class ApplicationController < ActionController::Base
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  protect_from_forgery with: :exception

  include SortHelper

  def alert_errors(resource)
    flash.alert = resource.errors.to_a.join '. '
  end

  def authenticate_person!
    return if user_signed_in? || student_signed_in?
    message = t('devise.failure.unauthenticated')
    redirect_to new_student_session_path, alert: message
  end

  def current_person
    current_student || current_user
  end

  private def user_not_authorized
    flash.alert = 'Access denied'
    redirect_to request.referrer || root_path
  end
end

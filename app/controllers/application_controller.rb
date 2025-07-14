class ApplicationController < ActionController::Base
  skip_forgery_protection

  helper_method :admin_signed_in?
  def admin_signed_in?
    request.env['REMOTE_USER'].present?
  end
end

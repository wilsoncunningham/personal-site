class HomeController < ApplicationController

  before_action :require_admin, only: []

  def index
    render({:template => "home"})
  end

  def career
    render({:template => "career"})
  end

  def privacy_policy
    render({:template => "privacy_policy"})
  end
  
  def cookie_settings
    render({:template => "cookie_settings"})
  end

  def bins_and_balls
    render({:template => "bins_and_balls"})
  end

  private

  def require_admin
    unless current_user&.admin?
      redirect_to root_path, alert: "Access denied."
    end
  end

end

class HomeController < ApplicationController
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
end

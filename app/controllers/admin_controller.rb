class AdminController < ApplicationController
  before_action :authenticate_user!

  def dashboard
    # Admin landing page
  end

end

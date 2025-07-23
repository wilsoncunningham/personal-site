class AdminController < ApplicationController
  before_action :require_admin

  def dashboard
    # Admin landing page
  end

  def books
    @book = Book.new
    render(:template => "admin/books")
  end

  private

  def require_admin
    unless current_user&.admin?
      redirect_to root_path, alert: "Access denied."
    end
  end

end

class AdminController < ApplicationController
  before_action :authenticate_user!

  def dashboard
    # Admin landing page
  end

  def books
    @book = Book.new
    render(:template => "admin/books")
  end

  # In the future: more admin actions (hiking, articles, etc.)
end

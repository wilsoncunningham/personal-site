class HomeController < ApplicationController
  def index
    render({:template => "home"})
  end

  def career
    render({:template => "career"})
  end

  def hiking
    render({:template => "hiking"})
  end
end

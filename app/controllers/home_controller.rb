class HomeController < ApplicationController
  def index
    render({:template => "home"})
  end

  def career
    render({:template => "career"})
  end
end

class ReadingController < ApplicationController
  def home
    render({:template => "reading/home"})
  end
end

class PhotosController < ApplicationController

  before_action :require_admin

  def index
    @photos = Photo.all
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params)
    if @photo.save
      redirect_to photos_path, notice: "Photo added successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def photo_params
    params.require(:photo).permit(:title, :caption, :tag, :position, :image)
  end
  
  def require_admin
    unless current_user&.admin?
      redirect_to root_path, alert: "Access denied."
    end
  end

end

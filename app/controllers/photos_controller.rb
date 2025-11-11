class PhotosController < ApplicationController

  before_action :require_admin
  before_action :set_photo, only: [:destroy]

  def gallery
    @photos = Photo.all
    render({:template => "hiking/gallery"})
  end

  def index
    @photos = Photo.all
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params.except(:image))

    if params[:photo][:image].present?
      processed = ImageProcessing::Vips
                    .source(params[:photo][:image])
                    .resize_to_limit(1600, 1600)
                    .call

      @photo.image.attach(
        io: File.open(processed.path),
        filename: params[:photo][:image].original_filename,
        content_type: params[:photo][:image].content_type
      )
    end

    if @photo.save
      redirect_to photos_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @photo = Photo.find(params[:id])
  end

  def update
    @photo = Photo.find(params[:id])
    if @photo.update(photo_params)
      redirect_to photos_path, notice: "Photo updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    @photo.image.purge if @photo.image.attached?
    @photo.destroy
    redirect_to photos_path, notice: "Photo deleted."
  end

  private

  def set_photo
    @photo = Photo.find(params[:id])
  end

  def photo_params
    params.require(:photo).permit(:title, :caption, :tag, :position, :image)
  end
  
  def require_admin
    unless current_user&.admin?
      redirect_to root_path, alert: "Access denied."
    end
  end

end

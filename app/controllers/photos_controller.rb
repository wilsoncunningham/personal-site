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

    # Attach the uploaded file directly and avoid synchronous
    # in-request image processing (which may load large files into
    # memory). Let Active Storage handle variants lazily or via a
    # background worker. Optionally, reject overly-large uploads here.
    if params[:photo][:image].present?
      uploaded = params[:photo][:image]

      # simple server-side size guard (adjust as needed)
      max_size = 8.megabytes
      if uploaded.size && uploaded.size > max_size
        # Reject too-large uploads to protect RAM; you can also
        # enqueue a background job to transcode/resize instead.
        flash.now[:alert] = "Image is too large (max #{max_size/1.megabyte} MB)."
        render :new, status: :unprocessable_entity and return
      end

      @photo.image.attach(
        io: uploaded.open,
        filename: uploaded.original_filename,
        content_type: uploaded.content_type
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

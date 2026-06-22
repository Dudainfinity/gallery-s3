class PhotosController < ApplicationController
  def index
    @photo = Photo.new
    @photos = Photo.with_attached_image.order(created_at: :desc)
  end

  def create
    @photo = Photo.new(photo_params)
    if @photo.save
      redirect_to root_path, notice: "Foto enviada com sucesso."
    else
      @photos = Photo.with_attached_image.order(created_at: :desc)
      render :index, status: :unprocessable_content
    end
  end

  def destroy
    Photo.find(params[:id]).destroy
    redirect_to root_path, notice: "Foto removida."
  end

  private

  def photo_params
    params.require(:photo).permit(:title, :caption, :image)
  end
end

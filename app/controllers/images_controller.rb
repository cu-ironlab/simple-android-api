class ImagesController < ApplicationController
  before_action :set_image, only: [:destroy]

  # GET /images
  def index
    @images = Image.all
  end

  # GET /images/new
  def new
    @image = Image.new
  end

  def create
    @image = Image.new(image_params)

    respond_to do |format|
      if @image.save
        # Via Web GUI
        flash[:notice] = 'Image successfully created'
        format.html { redirect_to action: "index" }
        # Via mobile GUI
        format.json { render :index, status: :created, location: @image }
      else
        format.html { render :new }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @image.destroy
    respond_to do |format|
      format.html { redirect_to images_url, notice: 'Image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_image
      @image = Image.find(params[:id])
    end

    def image_params
      params.require(:image).permit(:attachment)
    end
end

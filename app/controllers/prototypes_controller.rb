class PrototypesController < ApplicationController
  before_action :set_prototype, only: [:show, :edit, :update]

  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
    @prototype.captured_images.build
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to :root, notice: 'New prototype was successfully created'
    else
      redirect_to ({ action: new }), alert: 'YNew prototype was unsuccessfully created'
     end
  end

  def show
  end

  def edit
    @main_image = @prototype.captured_images.main.first
    sub_images = @prototype.captured_images.sub
    @prototype.captured_images.build
    @max = CapturedImage.maximum('id')
    @main_image.content.cache! unless @main_image.content.blank?
    i = 0
    @sub_image = []
    sub_images.each do |image|
      @sub_image[i] = image
      i += 1
    end
  end

  def update
    for i in 2..7 do
      image_params = prototype_params[:captured_images_attributes]["#{i}"]
      if CapturedImage.where(id: image_params[:id]).blank? && image_params[:content].present?
        @image = CapturedImage.create(image_params)
      end
    end
    if @prototype.user_id == current_user.id
      @prototype.update(prototype_params)
    end
    redirect_to action: 'show'
    flash[:notice] = "prototype was successfully edited"
  end

  private
  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def prototype_params
    params.require(:prototype).permit(
      :title,
      :catch_copy,
      :concept,
      :user_id,
      captured_images_attributes: [:content, :status, :id, :prototype_id]
    )
  end
end

class PrototypesController < ApplicationController
  before_action :set_prototype, only: [:show, :edit, :update]

  def index
    if params[:format].to_i == 2
      @prototypes = Prototype.order("created_at DESC").page(params[:page]).per(16)
    else
      @prototypes = Prototype.order("likes_count DESC").page(params[:page]).per(16)
    end
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
    @like = @prototype.like_user(current_user)
  end


  def destroy
    prototype = Prototype.find(params[:id])
    if prototype.user_id == current_user.id
      prototype.destroy
    end
  end

  def edit
    sub_images = @prototype.captured_images.sub
    @main_image = @prototype.captured_images.main
    @prototype.captured_images.build
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
      if CapturedImage.where(id: image_params[:id]).blank? && image_params[:content].present? && image_params[:prototype_id].present?
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

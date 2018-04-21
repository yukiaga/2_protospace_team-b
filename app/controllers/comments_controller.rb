class CommentsController < ApplicationController

  def index
    @comments = Comment.new(comment_params)
  end

  def new
    @comments = Comment.new
  end

  def create
    @comments = Comment.new(comment_params)
    if @comments.save
      redirect_to :root, notice: 'New comment was successfully created'
    else
      redirect_to ({ action: new }), alert: 'Your new comment was unsuccessfully created'
     end
  end

  def show
    @comments = Comment.new
  end

  private

  def comment_params
    params.require(:comment).permit(
      :comment
      :user_id
      :prototype_id
      )
  end
end

class CommentsController < ApplicationController
  before_action :set_post
  before_action :set_comment, only: [ :show, :update, :destroy ]

  #GET /posts/:post_id/comments
  def index
    @comments = @post.comments
  end

  #POST /posts/:post_id/comments
  def create
    @comment = @post.comments.new(comment_params)
    @comment.save!
    render action: :show, status: :created
  end

  #GET /posts/:post_id/comments/:id
  def show
  end

  #PUT/PATCH /posts/:post_id/comments/:id
  def update
    if @comment.update(comment_params)
      render action: :show, status: :ok
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  #DELETE /posts/:post_id/comments/:id
  def destroy
    @comment.destroy
    head :no_content
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end

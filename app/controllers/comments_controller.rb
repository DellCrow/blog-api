class CommentsController < ApplicationController
  before_action :set_post
  before_action :set_comment, except: [:index, :create] # only: [ :show, :update, :destroy ]
  before_action :authorized, except: [ :index, :show ]
  before_action :render_not_authorized, except: [ :index, :show, :create ]

  #GET /posts/:post_id/comments
  def index
    @comments = @post.comments
  end

  #POST /posts/:post_id/comments
  def create
    @comment = @post.comments.new(comment_params.merge!(user: @user))
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

  def authorized?
    case params[:action]
    when 'update'
      @user == @comment.user
    when 'destroy'
      @user == @comment.user || @user == @post.user
    end
  end
end
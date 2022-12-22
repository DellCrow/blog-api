class PostsController < ApplicationController
  before_action :set_post, only: [ :show, :update, :destroy ]


  #GET /posts
  def index
    @posts = Post.all
  end

  #POST /posts
  def create
    @post = Post.new(post_params)
    @post.save!
    render action: :show, status: :created
  end

  #GET /posts/:id
  def show
  end

  #PUT/PATCH /posts/:id
  def update
    if @post.update(post_params)
      render action: :show, status: :ok
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  #DELETE /posts/:id
  def destroy
    @post.destroy
    head :no_content
  end

  private

    def post_params
      params.require(:post).permit(:title, :description)
    end

    def set_post
      @post = Post.find(params[:id])

    end

end

class PostsController < ApplicationController
  before_action :authorized, except: [ :index, :show ]
  before_action :set_post, only: [ :show, :update, :destroy, :link_tag, :unlink_tag, :show_tags ]
  before_action :set_tag, only: [ :link_tag, :unlink_tag ]
  before_action :render_not_authorized, except: [ :index, :show, :create ]

  #GET /posts
  def index
    @posts = Post.all().includes(:likes, :comments)#, :comments, :tags, :user)
  end

  #POST /posts
  def create
    @post = Post.new(post_params.merge!(user: @user))
    @post.save!
    render action: :show, status: :created
  end

  #GET /posts/:id
  def show
  end

  #PUT/PATCH /posts/:id
  def update
    @post.update!(post_params)
    render action: :show, status: :ok
  end

  #GET /posts/:id/tags
  def show_tags
    @tags = @post.tags
    render 'tags/index', status: :ok
  end

  #DELETE /posts/:id
  def destroy
    @post.destroy
    head :no_content
  end

  #POST /posts/:id/tag
  def link_tag
    @post.tags.push(@tag)
    @tags = @post.tags
    render 'tags/index', status: :ok
  end

  #DELETE /posts/:id/tag
  def unlink_tag
    @post.tags.delete(@tag)
    @tags = @post.tags
    render 'tags/index', status: :ok
  end

  private

    def post_params
      params.require(:post).permit(:title, :description)
    end

    def tag_params
      params.require(:post).permit(:tag_id, tag_id: [])
    end

    def set_post
      @post = Post.find(params[:id])
    end

    def set_tag
      case params[:action]
      when 'link_tag'
        @tag = Tag.find(tag_params[:tag_id])
      when 'unlink_tag'
        @tag = @post.tags.find(tag_params[:tag_id])
      end
    end

    def authorized?
      @user == @post.user
    end
end
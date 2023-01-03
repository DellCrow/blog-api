class LikesController < ApplicationController
  before_action :authorized
  before_action :set_post, except: [ :commentLike, :unlikeComment ]
  before_action :set_comment, except: [ :postLike, :unlikePost ]
  before_action :set_like, only: [ :unlikePost, :unlikeComment ]
  before_action :render_not_authorized, only: [ :unlikePost, :UnlikeComment ]


  def post_like
    @like = Like.new(likeable: @post, user_id: @user.id)
    @like.save!
    render action: :show, status: :created
  end

  def comment_like
    @like = Like.new(likeable: @comment, user_id: @user.id)
    @like.save!
    render action: :show, status: :created
  end

  def unlike_post
    @like.destroy!
    head :no_content
  end

  def unlike_comment
    @like.destroy!
    head :no_content
  end


  private
  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = Comment.find(params[:comment_id])
  end

  def set_like
    @like = Like.find(params[:id])
  end

  def authorized?
    @user == @like.user
  end
end
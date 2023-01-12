class LikesController < ApplicationController
  before_action :set_post_like, only: [ :unlike_post ]
  before_action :set_comment_like, only: [ :unlike_comment ]
  before_action :authorized
  before_action :set_post, only: [ :comment_like, :unlike_comment, :post_like ]
  before_action :set_comment, only: [ :unlike_comment, :comment_like ]
  before_action :render_not_authorized, only: [ :unlike_post, :unlike_comment ]


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

    def set_post_like
      @like = Post.find(params[:post_id]).likes.find_by(user_id: @user.id)
    end

    def set_comment_like
      @like = Comment.find(params[:comment_id]).likes.find_by(user_id: @user.id)
    end

    def set_comment
      @comment = Comment.find(params[:comment_id])
    end

    def authorized?
      @user == @like.user
    end
end
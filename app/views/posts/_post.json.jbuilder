json.extract! post, :id, :title, :description, :user_id, :created_at, :updated_at
if with_childs
  json.tags do
    json.array! post.tags, partial: "tags/tag", as: :tag
  end

  json.comments do
    json.array! post.comments, partial: "comments/comment", as: :comment, with_likes: false
  end

  json.likes do
    json.array! post.likes, partial: "likes/like", as: :like
  end
end

if !with_childs
  json.likes_count post.likes.size
  json.comments_count post.comments.size
end

if @user && post.likes.find{| userliked | userliked.user_id == @user.id }
  json.liked true
else
  json.liked false
end
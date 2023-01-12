json.extract! comment, :id, :text, :user_id, :created_at
if with_likes
  json.likes do
    json.array! comment.likes, partial: "likes/like", as: :like
  end
end


if !with_likes
  json.likes_count comment.likes.size
end

if @user && comment.likes.find{| userliked | userliked.user_id == @user.id }
  json.liked true
else
  json.liked false
end
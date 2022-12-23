json.extract! post, :id, :title, :description
if with_childs
  json.tags do
    json.array! post.tags, partial: "tags/tag", as: :tag
  end
  json.comments do
    json.array! post.comments, partial: "comments/comment", as: :comment
  end
end

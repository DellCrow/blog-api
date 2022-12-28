class AddUserToPost < ActiveRecord::Migration[6.1]
  def up
    add_reference :posts, :user, foreign_key: true
    Post.update(user_id: User.first.id)
    change_column_null :posts, :user_id, false
  end

  def down
    remove_reference :posts, :user
  end
end

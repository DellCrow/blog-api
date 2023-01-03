class AddPasswordToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :password_digest, :string, null: false
    User.update(password: "123456")
  end
end
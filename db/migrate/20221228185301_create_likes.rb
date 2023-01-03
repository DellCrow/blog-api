class CreateLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :likes do |t|
      t.references :likeable, polymorphic: true, index: true
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
    add_index :likes, [:likeable_id, :likeable_type, :user_id], unique: true
  end
end
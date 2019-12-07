class AddIndexToJoinTablePostsUsers < ActiveRecord::Migration[5.2]
  def change
    drop_table :posts_users

    create_table :favorite_posts do |t|
      t.references :user
      t.references :post
    end
  end
end

class AddPostToMessage < ActiveRecord::Migration[5.2]
  def change
    add_reference :messages, :post, index: true
    add_foreign_key :messages, :posts
  end
end

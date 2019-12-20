class RemovePostForeignKeyFromMessages < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :messages, :posts
  end
end

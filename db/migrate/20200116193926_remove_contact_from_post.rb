class RemoveContactFromPost < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :contact
  end
end

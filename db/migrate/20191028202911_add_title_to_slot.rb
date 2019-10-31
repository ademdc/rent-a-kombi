class AddTitleToSlot < ActiveRecord::Migration[5.2]
  def change
    add_column :slots, :title, :string
  end
end

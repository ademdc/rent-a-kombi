class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.references :category
      t.string :images
      t.text :description
      t.string :contact

      t.timestamps
    end
  end
end

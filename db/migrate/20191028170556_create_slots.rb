class CreateSlots < ActiveRecord::Migration[5.2]
  def change
    create_table :slots do |t|
      t.references :post
      t.datetime :start
      t.datetime :end

      t.timestamps
    end
  end
end

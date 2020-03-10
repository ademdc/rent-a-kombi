class AddFreeDucatsToUsers < ActiveRecord::DataMigration
  def up
    User.all.update_all(ducats: User::INNITIAL_DUCATS_COUNT)
  end
end
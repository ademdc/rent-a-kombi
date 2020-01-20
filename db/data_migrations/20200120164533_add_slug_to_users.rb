class AddSlugToUsers < ActiveRecord::DataMigration
  def up
    User.all.each do |user|
      slug_name = "#{user.first_name.downcase}-#{user.last_name.downcase}"
      user.slug = slug_name
      user.save!
    end
  end
end
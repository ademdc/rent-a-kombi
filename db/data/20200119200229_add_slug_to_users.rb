class AddSlugToUsers < ActiveRecord::Migration[5.2]
  def self.up
    User.all.each do |user|
      slug_name = "#{user.first_name}-#{user.last_name}"
      user.slug = slug_name
      user.save!
    end
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end

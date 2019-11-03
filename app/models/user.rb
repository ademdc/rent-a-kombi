class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_one_attached :avatar


  def admin?
    is_admin
  end

  def my_post?(post)
    self.id==post.user.id
  end

  def full_name
    first_name && last_name ? "#{first_name} #{last_name}" : email
  end

  def ability
    @ability ||= Ability.new(self)
  end
end

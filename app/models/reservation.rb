class Reservation < ApplicationRecord
  include PostsHelper

  belongs_to :post
  belongs_to :user, optional: true
  validates  :post_id, :start, :end, presence: true

  validate :not_my_post?
  validate :does_not_overlap?, on: :create

  delegate :currency, to: :post

  scope :current_reservation_for, ->(user, post) { where('user_id = ? AND post_id = ? AND start > ?', user.id, post.id, Time.now ) }
  scope :for_post, -> (post_id) { where('post_id = ? AND confirmed = ?', post_id, true) }
  scope :active, -> { where('start > ?', Time.now) }
  scope :active_and_confirmed, -> { active.where(confirmed: true) }

  after_create :send_confirmation_emails

  DUCAT_RATIO = 0.05

  def self.outgoing_reservation_for(user)
    Reservation.where(user_id: user.id)
  end

  def self.incoming_reservation_for(user)
    Reservation.active.includes(:post).where(posts: { user_id: user.id })
  end

  def between_range?(from, to)
    (from..to).include?(self.start) || (from..to).include?(self.end)
  end

  def days_number
    (self.start.to_date..self.end.to_date).count
  end

  def pending_price
    days_number * self.post.price
  end

  def pending_price_w_currency
    "#{days_number * self.post.price} #{self.currency.symbol}"
  end

  def price_w_currency
    "#{price} #{self.currency.symbol}"
  end

  def set_price!
    self.price = days_number * self.post.price
    self.save
  end

  def confirm!(user)
    if user.has_enough_ducats?(self.ducat_price)
      self.confirmed = true
      self.save
      user.deduct_ducats(self.ducat_price)
    else
      false
    end
  end

  def ducat_price
    (price * DUCAT_RATIO).to_i
  end

  protected

    def send_confirmation_emails
      UserMailer.with(reservation: self).reservation_confirmation.deliver_now
    end

    def not_my_post?
      self.errors[:base] << 'Can not reserve your own post!' if self.user_id == self.post.user.id
    end

    def does_not_overlap?
      self.errors[:base] << 'Post is reserved for that range' if ApplicationController.helpers.posts_with_reservations_in_range_for?(self).present?
    end
end

class Post < ApplicationRecord
  include Filterable
  include WithAddresses
  include PostsHelper

  belongs_to  :category
  belongs_to  :user
  belongs_to  :currency
  has_many    :reservations, dependent: :destroy
  has_many    :slots, dependent: :destroy
  has_many    :messages
  has_many    :favorite_posts, dependent: :destroy
  # has_many    :currency_prices, through: :currencies_posts

  has_many_attached :images

  scope :all_except, -> (ids) { where.not(id: ids) }
  scope :by_user, -> (user) { where(user_id: user.id) }

  scope :with_reservations_in_range, -> (range) { joins(:reservations).where(reservations: { start: range, confirmed: true }).or(joins(:reservations).where(reservations: { end: range, confirmed: true })).or(joins(:reservations).where('reservations.start > ? AND reservations.end < ? AND reservations.confirmed = ?', range.first, range.last, true)) }
  scope :by_category, -> (category) { joins(:category).where('categories.name = ?', category) }
  scope :by_model, -> (model) { where(model: model) }
  scope :by_fuel, -> (fuel) { where(fuel: fuel) }
  scope :by_transmission, -> (transmission) { where(transmission: transmission) }
  scope :by_year_from, -> (year) { where('production_year > ?', year) }
  scope :by_year_to, -> (year) { where('production_year < ?', year) }
  scope :by_price_from, -> (price) { where('price > ?', price) }
  scope :by_price_to, -> (price) { where('price < ?', price) }
  scope :by_city, -> (city) { includes(:address).where(addresses: { city: city.split(',').first }) }

  scope :by_availability_from, -> (availability) {  }
  scope :by_availability_to, -> (availability) { }

  scope :not_from_user, -> (user) { where.not(user_id: user.id) if user }

  validates :title, :price, :model, :production_year, :currency_id, presence: true

  enum model: Vehicles::Models::MODELS
  enum fuel: Posts::Filters::FUEL
  enum transmission: Posts::Filters::TRANSMISSION

  # self.per_page = 5

  def self.by_availability(range)
    from, to = range.split('to').map(&:to_datetime)
    range = from.beginning_of_day..to.end_of_day

    reserved_post_ids = Reservation.where(start: range).or(Reservation.where(end: range)).pluck(:post_id)
    Post.all_except(reserved_post_ids)
  end

  def self.favorite_posts_for(user)
    FavoritePost.where(user_id: user.id)
  end

  def cover_image
    self.images.first.present? ? self.images.first : 'cars/car.jpg'
  end

  def listing_image
     self.images.first.present? ? self.images.first.variant(resize: '400x400') : 'cars/car.jpg'
  end

  def available?(date_from, date_to)
    return unless date_from.present? && date_to.present?

    from, to = date_from.to_datetime, date_to.to_datetime
    self.reservations.each { |reservation| return false if (reservation.between_range?(from, to) && reservation.confirmed) }
    true
  end

  def use_user_address
    user_address = self.user.address.dup
    self.address.delete if self.address&.persisted?
    self.address = user_address
  end

  def price_w_currency
    "#{self.price} #{self&.currency.symbol}"
  end

end

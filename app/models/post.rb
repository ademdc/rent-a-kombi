class Post < ApplicationRecord
  include Filterable

  belongs_to :category
  belongs_to :user
  has_one :vehicle, dependent: :destroy
  has_many :slots, dependent: :destroy
  has_many :messages

  has_many_attached :images

  scope :all_except, -> (ids) { where.not(id: ids) }
  scope :by_user, -> (user) { where(user_id: user.id) }

  scope :slot_in_range, -> (range) { joins(:slots).where(slots: { start: range }).or(joins(:slots).where(slots: { end: range })) }
  scope :by_category, -> (category) { joins(:category).where('categories.name = ?', category) }
  scope :by_model, -> (model) { where(model: model) }
  scope :by_fuel, -> (fuel) { where(fuel: fuel) }
  scope :by_transmission, -> (transmission) { where(transmission: transmission) }
  scope :by_year_from, -> (year) { where('production_year > ?', year) }
  scope :by_year_to, -> (year) { where('production_year < ?', year) }
  scope :by_price_from, -> (price) { where('price > ?', price) }
  scope :by_price_to, -> (price) { where('price < ?', price) }

  scope :by_availability_from, -> (availability) { where('price < ?', price) }
  scope :by_availability_to, -> (availability) { where('price < ?', price) }


  validates :title, :price, :model, presence: true

  enum model: Vehicles::Models::MODELS
  enum fuel: Posts::Filters::FUEL
  enum transmission: Posts::Filters::TRANSMISSION

  self.per_page = 5

  def self.by_availability(range)
    from, to = range.split('to').map(&:to_datetime)
    range = from.beginning_of_day..to.end_of_day

    reserved_post_ids = Slot.where(start: range).or(Slot.where(end: range)).pluck(:post_id)
    Post.all_except(reserved_post_ids)
  end

  def cover_image
    self.images.first.present? ? self.images.first : 'cars/car.jpg'
  end

  def available?(date_from, date_to)
    from, to = date_from.to_datetime, date_to.to_datetime
    self.slots.each { |slot| return false if slot.between_range?(from, to) }
    true
  end

end

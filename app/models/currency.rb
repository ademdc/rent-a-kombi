class Currency < ApplicationRecord
  has_many :posts

  EUR = 'EUR'
  BAM = 'BAM'

  scope :without_eur, -> { where.not(code: EUR) }
  scope :by_code, ->(code) { where('code ILIKE(?)', code) }

  def self.eur
    find_by(code: EUR)
  end

  def self.bam
    find_by(code: BAM)
  end

  def eur?
    code == EUR
  end

  def bam?
    code == BAM
  end

  def convert(value_in_euro)
    value_in_euro * value
  end

  def to_eur(value_to_convert)
    value_to_convert / value
  end

  def self.conversion_rate(base_currency, converting_currency)
    if base_currency.eur?
      converting_currency.value
    else
      converting_currency.value / base_currency.value
    end
  end
end

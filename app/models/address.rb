class Address < ApplicationRecord
  belongs_to :reference, polymorphic: true, optional: true
end

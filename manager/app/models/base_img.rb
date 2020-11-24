class BaseImg < ApplicationRecord
  has_many :instances, dependent: :nullify

  validates :name, uniqueness: true, presence: true
  validates :size, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :path, presence: true
end

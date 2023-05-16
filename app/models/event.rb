class Event < ApplicationRecord
  has_many :attendances
  has_many :guests, through: :attendances, source: :guest
  belongs_to :admin, class_name: 'User'

  
  validates :start_date, presence: true
  validate :start_date_cannot_be_in_the_past

  def start_date_cannot_be_in_the_past
    if start_date.present? && start_date < Time.current
      errors.add(:start_date, "can't be in the past")
    end
  end

  validates :duration, presence: true, numericality: { only_integer: true, greater_than: 0, divisible_by: 5 }
  validates :title, presence: true, length: { minimum: 5, maximum: 140 }
  validates :description, presence: true, length: { in: 20..1000 }
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 1000 }
  validates :location, presence: true
end

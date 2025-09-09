class Lesson < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :participation_fee, numericality: { only_integer: true, greater_than: 0 }

  scope :default_order, -> { order(:id) }
  # scope :published, -> { where(is_published: true) }
end

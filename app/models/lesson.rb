class Lesson < ApplicationRecord
  acts_as_list

  validates :name, presence: true
  validates :description, presence: true
  validates :participation_fee, numericality: { only_integer: true, greater_than: 0 }

  scope :default_order, -> { order(:position) }
  scope :published, -> { where(is_published: true) }
end

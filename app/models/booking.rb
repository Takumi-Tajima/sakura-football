class Booking < ApplicationRecord
  COURT_FEE_PER_GROUP = 1200
  PARTICIPANTS_PER_GROUP = 5

  belongs_to :user
  belongs_to :lesson

  validates :lesson_name, presence: true
  validates :lesson_at, presence: true
  validates :total_fee, numericality: { only_integer: true, greater_than: 0 }
  validates :court_fee, numericality: { only_integer: true, greater_than: 0 }
  validates :participation_fee, numericality: { only_integer: true, greater_than: 0 }
  validates :participant_count, numericality: { only_integer: true, greater_than: 0 }

  before_validation :set_lessons_name
  before_validation :set_participation_fee
  before_validation :calculate_and_set_court_fee
  before_validation :calculate_and_set_total_fee
  before_validation :calculate_and_set_lessons_at

  scope :default_order, -> { order(:id) }

  private

  def set_lessons_name
    self.lesson_name = lesson.name
  end

  def set_participation_fee
    self.participation_fee = lesson.participation_fee
  end

  def set_lessons_at
    self.lesson_at = Time.current
  end

  def calculate_and_set_court_fee
    group_count = ((participant_count - 1) / PARTICIPANTS_PER_GROUP) + 1
    self.court_fee = group_count * COURT_FEE_PER_GROUP
  end

  def calculate_and_set_total_fee
    self.total_fee = court_fee + (participation_fee * participant_count)
  end
end

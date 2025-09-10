class Booking < ApplicationRecord
  COURT_FEE_PER_GROUP = 1200
  PARTICIPANTS_PER_GROUP = 5
  LESSON_TIME_SLOTS = %w[09-11 11-13 13-15 15-17 17-19 19-21].freeze
  MIN_BUSINESS_DAYS = 3
  MAX_BUSINESS_DAYS = 14

  belongs_to :user
  belongs_to :lesson

  attr_accessor :lesson_date, :lesson_time_slot

  validates :lesson_name, presence: true
  validates :lesson_start_at, presence: true
  validates :lesson_end_at, presence: true
  validates :total_fee, numericality: { only_integer: true, greater_than: 0 }
  validates :court_fee, numericality: { only_integer: true, greater_than: 0 }
  validates :participation_fee, numericality: { only_integer: true, greater_than: 0 }
  validates :participant_count, numericality: { only_integer: true, greater_than: 0 }

  before_validation :set_lessons_name
  before_validation :set_participation_fee
  before_validation :calculate_and_set_lesson_at
  before_validation :calculate_and_set_court_fee
  before_validation :calculate_and_set_total_fee

  scope :default_order, -> { order(:id) }

  def self.available_dates
    (MIN_BUSINESS_DAYS..MAX_BUSINESS_DAYS).filter_map do |days|
      date = Date.current + days
      date if date.on_weekday?
    end
  end

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
    # MEMO: before_validationで実行されるため、participant_countがnilだとエラーになる。
    group_count = ((participant_count - 1) / PARTICIPANTS_PER_GROUP) + 1
    self.court_fee = group_count * COURT_FEE_PER_GROUP
  end

  def calculate_and_set_total_fee
    self.total_fee = court_fee + (participation_fee * participant_count)
  end

  def calculate_and_set_lesson_at
    date = Date.parse(lesson_date)
    start_hour, end_hour = lesson_time_slot.split('-').map(&:to_i)

    self.lesson_start_at = date + start_hour.hours
    self.lesson_end_at = date + end_hour.hours
  end
end

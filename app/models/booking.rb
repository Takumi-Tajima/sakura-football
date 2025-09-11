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
  validates :participation_fee, presence: true
  validates :participant_count, numericality: { only_integer: true, greater_than: 0 }
  validates :court_fee, presence: true
  validates :total_fee, presence: true

  before_validation :validate_participant_count_presence
  before_validation :validate_lesson_date_within_available_dates
  before_validation :validate_lesson_time_slot_within_available_time_slots
  before_validation :set_booking_attributes, on: :create

  scope :default_order, -> { order(:lesson_start_at) }
  scope :history, -> { where('lesson_end_at < ?', Time.current) }
  scope :upcoming, -> { where('lesson_end_at >= ?', Time.current) }

  def self.available_dates
    (MIN_BUSINESS_DAYS..MAX_BUSINESS_DAYS).filter_map do |days|
      date = Date.current + days
      date if date.on_weekday?
    end
  end

  private

  def validate_participant_count_presence
    if participant_count.nil?
      errors.add(:participant_count, 'を入力してください。')
      throw(:abort)
    end
  end

  def validate_lesson_date_within_available_dates
    if Booking.available_dates.exclude?(lesson_date.to_date)
      errors.add(:lesson_date, 'は平日の3営業日から14営業日までを選択してください。')
      throw(:abort)
    end
  end

  def validate_lesson_time_slot_within_available_time_slots
    if LESSON_TIME_SLOTS.exclude?(lesson_time_slot)
      errors.add(:lesson_time_slot, 'は有効な時間帯を選択してください。')
      throw(:abort)
    end
  end

  def set_booking_attributes
    self.lesson_name = lesson.name
    self.participation_fee = lesson.participation_fee
    self.court_fee = calculate_court_fee
    self.total_fee = calculate_total_fee # NOTE: court_feeの値に依存
    self.lesson_start_at, self.lesson_end_at = calculate_lesson_start_at_and_end_at
  end

  def calculate_court_fee
    group_count = ((participant_count - 1) / PARTICIPANTS_PER_GROUP) + 1
    group_count * COURT_FEE_PER_GROUP
  end

  def calculate_total_fee
    court_fee + (participation_fee * participant_count)
  end

  def calculate_lesson_start_at_and_end_at
    date = Date.parse(lesson_date)
    start_hour, end_hour = lesson_time_slot.split('-').map(&:to_i)

    start_at = date + start_hour.hours
    end_at = date + end_hour.hours

    [start_at, end_at]
  end
end

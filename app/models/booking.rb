class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :lesson

  scope :default_order, -> { order(:id) }
end

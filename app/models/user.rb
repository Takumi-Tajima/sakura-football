class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :trackable, :confirmable

  has_many :bookings, dependent: :destroy

  scope :default_order, -> { order(:id) }
end

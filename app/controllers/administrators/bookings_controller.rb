class Administrators::BookingsController < Administrators::ApplicationController
  def index
    @bookings = Booking.includes(:lesson, :user).upcoming.default_order
  end
end

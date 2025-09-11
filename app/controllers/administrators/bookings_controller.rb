class Administrators::BookingsController < Administrators::ApplicationController
  def index
    @bookings = Booking.includes(:lesson, :user).default_order
  end
end

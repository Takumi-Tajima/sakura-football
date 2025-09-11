class Users::BookingsController < Users::ApplicationController
  before_action :set_booking, only: %i[show]

  def index
    @bookings = current_user.bookings.upcoming.default_order
  end

  def show
  end

  private

  def set_booking
    @booking = current_user.bookings.upcoming.find(params.expect(:id))
  end
end

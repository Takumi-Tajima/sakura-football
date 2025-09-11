class Users::BookingHistoriesController < Users::ApplicationController
  before_action :set_booking_history, only: %i[show]

  def index
    @booking_histories = current_user.bookings.history.default_order
  end

  def show
  end

  private

  def set_booking_history
    @booking_history = current_user.bookings.history.find(params.expect(:id))
  end
end

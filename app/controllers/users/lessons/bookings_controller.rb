class Users::Lessons::BookingsController < Users::ApplicationController
  before_action :set_lesson, only: %i[new create destroy]
  before_action :set_booking, only: %i[destroy]

  def new
    @booking = current_user.bookings.build
  end

  def create
    @booking = current_user.bookings.build(booking_params)
    @booking.lesson = @lesson

    if @booking.save
      redirect_to users_bookings_path, notice: 'レッスンを予約しました。'
    else
      render :new, status: :unprocessable_content
    end
  end

  def destroy
  end

  private

  def set_lesson
    @lesson = Lesson.published.find(params.expect(:lesson_id))
  end

  def set_booking
    @booking = current_user.bookings.find(params.expect(:id))
  end

  def booking_params
    params.expect(booking: %i[participant_count lesson_date lesson_time_slot])
  end
end

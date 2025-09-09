class Users::Lessons::BookingsController < Users::ApplicationController
  before_action :set_lesson, only: %i[index show new create destroy]
  before_action :set_booking, only: %i[show destroy]

  def index
    @bookings = current_user.bookings.includes(:lesson).default_order
  end

  def show
  end

  def new
    @booking = current_user.bookings.build
  end

  def create
    @booking = current_user.bookings.build(booking_params)

    if @booking.save
      redirect_to users_lesson_bookings_path(@lesson), notice: '成功'
    else
      render :new, status: :unprocessable_content
    end
  end

  def destroy
  end

  private

  def set_lesson
    @lesson = Lesson.find(params.expect(:lesson_id))
  end

  def set_booking
    @booking = current_user.bookings.find(params.expect(:id))
  end

  def booking_params
    params.expect(booking: %i[participant_count participation_fee court_fee total_fee lesson_name lesson_at lesson_id])
  end
end

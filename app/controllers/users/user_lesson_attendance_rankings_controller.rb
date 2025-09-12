class Users::UserLessonAttendanceRankingsController < Users::ApplicationController
  def index
    @users = Booking.user_lesson_attendance_rankings
  end
end

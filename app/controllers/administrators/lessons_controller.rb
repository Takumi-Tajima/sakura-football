class Administrators::LessonsController < Administrators::ApplicationController
  before_action :set_lesson, only: %i[show edit update destroy]

  def index
    @lessons = Lesson.default_order
  end

  def show
  end

  def new
    @lesson = Lesson.new
  end

  def edit
  end

  def create
    @lesson = Lesson.new(lesson_params)

    if @lesson.save
      redirect_to administrators_lesson_path(@lesson), notice: 'レッスンを作成しました。'
    else
      render :new, status: :unprocessable_content
    end
  end

  def update
    if @lesson.update(lesson_params)
      redirect_to administrators_lesson_path(@lesson), notice: 'レッスンを更新しました。'
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @lesson.destroy!
    redirect_to administrators_lessons_path, notice: 'レッスンを削除しました。', status: :see_other
  end

  private

  def set_lesson
    @lesson = Lesson.find(params.expect(:id))
  end

  def lesson_params
    params.expect(lesson: %i[name description participation_fee is_published position])
  end
end

class Administrators::UsersController < Administrators::ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  def index
    @users = User.default_order
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to administrators_user_path(@user), notice: 'ユーザー情報を更新しました。'
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @user.destroy!
    redirect_to administrators_users_path, notice: 'ユーザーを削除しました。', status: :see_other
  end

  private

  def set_user
    @user = User.find(params.expect(:id))
  end

  def user_params
    params.expect(user: %i[name email])
  end
end

class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update]

  def index
    @users = User.all

    @q = User.ransack(params[:q])
    @users = @q.result(dinstinct: true)
  end

  def edit
    authorize @user
  end

  def update
    authorize @user
    if @user.update(user_params)
      redirect_to users_path, notice: "User #{@user.email} was succefully updated"
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit({role_ids: []})
  end
end

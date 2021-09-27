class UsersController < ApplicationController
  def index
    @users = User.all

    @q = User.ransack(params[:q])
    @users = @q.result(dinstinct: true)
  end
end
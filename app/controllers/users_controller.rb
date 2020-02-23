class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :is_logged_in, only: [:show, :edit, :update]
  before_action :check_current_user, only: [:edit, :update]

  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice:"プロフィールを編集しました"
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :image, :image_cache)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def is_logged_in
    @current_user = User.find_by(id: session[:user_id])
    if @current_user.nil?
      redirect_to new_session_path
    end
  end

  def check_current_user
    @current_user = User.find_by(id: session[:user_id])
    if @current_user.id != params[:id].to_i
      redirect_to user_path(@user.id), notice:"編集権限がありません"
    end
  end

end

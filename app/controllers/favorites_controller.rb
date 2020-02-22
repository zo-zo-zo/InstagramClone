class FavoritesController < ApplicationController
  before_action :is_logged_in, only: [:show]

  def create
    favorite = current_user.favorites.create(blog_id: params[:blog_id])
    redirect_to blogs_url, notice: "#{favorite.blog.user.name}さんのブログをお気に入り登録しました"
  end

  def destroy
    favorite = current_user.favorites.find_by(id: params[:id]).destroy
    redirect_to blogs_url, notice: "#{favorite.blog.user.name}さんのブログをお気に入り解除しました"
  end

  def show
    @favorite = current_user.favorites
  end

  private

  def is_logged_in
    @current_user = User.find_by(id: session[:user_id])
    if @current_user.nil?
      redirect_to new_session_path
    end
  end

end

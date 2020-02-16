class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy ]
  before_action :is_logged_in, only: [:index, :show, :edit, :update ]

  def index
    @blogs = Blog.all
  end

  def new
    @blog = Blog.new
  end

  def confirm
    @blog = current_user.blogs.build(blog_params)
    render :new if @blog.invalid?
  end

  def create
    @blog = current_user.blogs.build(blog_params)
    if params[:back]
      render :new
    else
      if @blog.save
        CheckMailer.check_mail(@blog).deliver
        redirect_to blogs_path, notice: "ブログを作成しました！"
      else
        render :new
      end
    end
  end

  def show
    @favorite = current_user.favorites.find_by(blog_id: @blog.id)
  end

  def edit
  end

  def update
    if @blog.update(blog_params)
      CheckMailer.check_mail(@blog).deliver
      redirect_to blogs_path, notice: "ブログを編集しました！"
    else
      render :edit
    end
  end

  def destroy
    @blog.destroy
  redirect_to blogs_path, notice:"ブログを削除しました！"
  end

  private

  def is_logged_in
    @current_user = User.find_by(id: session[:user_id])
    if @current_user.nil?
      redirect_to new_session_path
    end
  end

  def blog_params
    params.require(:blog).permit(:title, :content, :picture, :picture_cache)
  end

  def set_blog
    @blog = Blog.find(params[:id])
  end
end

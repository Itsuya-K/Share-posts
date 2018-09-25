class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  before_action :login_limit, only: [:new, :edit, :show, :destroy]
  before_action :set_limit, only: [:edit, :destroy]

  def index
    @blogs = Blog.all
  end

  def new
    if params[:back]
      @blog = Blog.new(blog_params)
    else
      @blog = Blog.new
    end
  end

  def create
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id #現在ログインしているuserのidをblogのuser_idカラムに挿入する。
    if @blog.save
      # 一覧画面へ遷移して"ブログを作成しました！"とメッセージを表示します。
      redirect_to blogs_path, notice: "ツイートしました！"
    else
      # 入力フォームを再描画します。
      render 'new'
    end
  end

  def show
    @favorite = current_user.favorites.find_by(blog_id: @blog.id)
  end

  def edit
  end

  def update
    if @blog.update(blog_params)
      redirect_to blogs_path, notice: "ツイートを編集しました！"
    else
      render 'edit'
    end
  end

  def destroy
    @blog.destroy
    redirect_to blogs_path, notice:"ツイートを削除しました！"
  end

  def confirm
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id #現在ログインしているuserのidをblogのuser_idカラムに挿入する。
    # binding.pry
    render :new if @blog.invalid?
  end

  private

  def blog_params
    params.require(:blog).permit(:title, :content, :user_id)
  end

  def set_blog
    @blog = Blog.find(params[:id])
  end

  # current_userが存在していなければ、強制的にログイン画面にリダイレクトさせる
  def login_limit
    if logged_in? == false
      redirect_to new_session_path, notice:"ログインしてください！"
    end
  end

  def set_limit
    unless current_user.id == @blog.user_id then
      redirect_to blog_path, notice:"あなたはこのツイートを編集できません！"
    end
  end
end

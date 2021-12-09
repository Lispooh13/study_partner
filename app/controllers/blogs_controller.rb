class BlogsController < ApplicationController
  include SessionsHelper
  before_action :ensure_correct_user, only: [:edit]

  def index
    @blog = Blog.new
    @blogs = Blog.all
    @user = current_user
    @users = User.all
  end


  def create
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id
    if @blog.save
      flash[:notice] = "You have created book successfully."
      redirect_to blog_path(@blog)
    else
      @user = current_user
      @blogs = Blog.all
      render :index
    end
  end


  def show
    @blog = Blog.find(params[:id])
    @user = @blog.user
    @blogs = Blog.new
  end

  def edit
    @blog = Blog.find(params[:id])
    if @blog.user == current_user
      render :edit
    end
  end

  def update
    @blog = Blog.find(params[:id])
    if @blog.update(blog_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to blog_path(@blog)
    else
      render :edit
    end
  end

  def destroy
    @blog = Blog.find(params[:id])
    @blog.destroy
    redirect_to blogs_path
  end


  private

  def blog_params
    params.require(:blog).permit(:title,:subject, :body, :user_id)
  end


  def ensure_correct_user
    @blog = Blog.find(params[:id])
    unless @blog.user == current_user
      redirect_to blogs_path
    end
  end
end

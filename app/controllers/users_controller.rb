class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to blogs_path
    else
      render "new"
    end
  end

  def show
    @user = User.find(params[:id])
    @blogs = @user.blogs
    @blog = Blog.new
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render :edit
    else
      render :user_path
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:notice] = "プロフィールを更新しました。"
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def index
    @blog = Blog.new
    @blogs = Blog.all
    @users = User.all
    @user = current_user
  end

    private

    def user_params
      params.require(:user).permit(:name, :introduction, :email, :password, :password_confirmation)
    end
end

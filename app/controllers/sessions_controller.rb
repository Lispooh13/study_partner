class SessionsController < ApplicationController
  before_action :set_user, only: [:create]
  skip_before_action :require_log_in!, only: [:new, :create], raise: false

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to blogs_path
    else
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

  private

    def set_user
      @user = User.find_by!(email: session_params[:email])
    rescue
      flash.now[:danger] = t('.flash.invalid_mail')
      render action: 'new'
    end

    # 許可するパラメータ
    def session_params
      params.require(:session).permit(:email, :password)
    end

    def require_log_in!
      redirect_to login_path unless logged_in?
    end


end
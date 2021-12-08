module SessionsHelper
  
  def log_in(user)
     byebug
    session[:user_id] = user.id
  end
  
  def current_user
   
    @current_user ||= User.find_by(id: session[:user_id])
  end
  
  def logged_in?
    !current_user.nil?
    # ログイン中の状態＝セッションにユーザーが存在する＝current_userがnilでない状態。
  end
  
  def log_out
    #セッションからユーザーIDを削除
    session.delete(:user_id)
    #現在のユーザーをnilに設定
    @current_user = nil
    
  end
  
end

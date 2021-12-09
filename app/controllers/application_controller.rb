class ApplicationController < ActionController::Base
 include SessionsHelper

 def require_log_in!
  redirect_to login_path unless logged_in?
 end

end
module SessionsHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
    # @current_user || @current_user = User.find_by(id: session[:user_id])と同じ意味
    # @current_userが真の場合はそのままにし、偽の場合は右辺の値 User.find_by(id: session[:user_id]) を代入
  end
  
  def logged_in?
    current_user.present?
  end
end

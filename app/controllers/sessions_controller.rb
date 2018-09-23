class SessionsController < ApplicationController
  def new
  end

  def create
    # 送信されたメールアドレスを元に、find_byメソッドでデータベースからユーザを取り出し
    user = User.find_by(email: params[:session][:email].downcase)
    # パスワードが一致しているかを判定するためにはhas_secure_passwordが提供するauthenticateメソッドを使用
    if user && user.authenticate(params[:session][:password])
      # ログイン成功した場合
      session[:user_id] = user.id
      redirect_to user_path(user.id)
    else
      # ログイン失敗した場合
      flash.now[:danger] = 'ログインに失敗しました'
      render 'new'
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:notice] = 'ログアウトしました'
    redirect_to new_session_path
  end
end

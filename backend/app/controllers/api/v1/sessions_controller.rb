class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: session_params[:email])

    if user&.authenticate(session_params[:password])
      token = JwtToken.call(user)

      render json: { message: "ログイン成功", token: token, user: { id: user.id, name: user.name, email: user.email } }, status: :ok
    else
      render json: { message: "メールアドレスまたは、パスワードが違います" }, status: :unprocessable_content
    end
  end

  def destroy
    render json: { message: "ログアウトしました" }, status: :ok
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end

end

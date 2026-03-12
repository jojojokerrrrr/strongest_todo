module Auth
  extend ActiveSupport::Concern

  def authenticate_user!
    if current_user.nil?
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  end

  def current_user
    @current_user ||= certification_user_token
  end

  private

  def certification_user_token
    header = request.headers["Authorization"]
    return nil if header.blank?

    token = header.split(" ").last
    decoded = JwtToken.decode(token)
    return nil unless decoded

    User.find_by(id: decoded[:user_id])
  end
end

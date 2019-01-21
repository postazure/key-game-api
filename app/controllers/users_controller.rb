class UsersController < ApplicationController
  def login
    validate_google_token!(expected_email: user_params[:email], id_token: user_params[:google_id_token])

    auth_token = SecureRandom.urlsafe_base64

    user = User.find_or_create_by(google_id_token: user_params[:google_id_token], email: user_params[:email])

    if user.update(auth_token: auth_token)
      render json: {token: auth_token}, status: :created
    else
      head :no_content
    end
  end

  def logout
    User.find_by(auth_token: user_params[:auth_token])&.update(auth_token: SecureRandom.urlsafe_base64)

    head :no_content
  end

  private

  def user_params
    params.require(:user).permit(:email, :google_id_token, :auth_token)
  end

  def validate_google_token!(expected_email:, id_token:)
    resp = HTTParty.get("https://www.googleapis.com/oauth2/v3/tokeninfo?id_token=#{id_token}")

    unless resp.code == 200 &&
        resp['email'] == expected_email &&
        check_audience(resp["aud"])
      raise Exception("Invalid Google auth token")
    end
  end

  def check_audience(aud)
    # Ensure that this token was issued for one of our applications
    [
        ENV['ISO_AUD'],
        ENV['ANDROID_AUD']
    ].include?(aud)
  end

end
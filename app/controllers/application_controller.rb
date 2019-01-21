class ApplicationController < ActionController::API
  before_action :authenticate_user

  private

  def authenticate_user
    google_token = request.headers['X-GOOGLE-ID-TOKEN']
    user_email = request.headers['X-USER-EMAIL']

    validate_google_token!(expected_email: user_email, id_token: google_token)
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

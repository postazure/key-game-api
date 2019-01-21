class ApplicationController < ActionController::API
  private

  def authenticate_user!
    token = request.headers['X-AUTH-TOKEN']
    raise "No user found with that token." unless User.find_by(auth_token: token)
  end
end

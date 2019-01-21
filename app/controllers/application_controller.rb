class ApplicationController < ActionController::API
  attr_reader :current_user

  private

  def authenticate_user!
    token = request.headers['X-AUTH-TOKEN']
    @current_user = User.find_by(auth_token: token)
    raise "No user found with that token." unless current_user
  end
end

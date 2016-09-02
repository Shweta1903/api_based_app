class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
 protect_from_forgery with: :null_session

  include Authenticable

   def authenticate_with_token!
    render json: { errors: "Not authenticated" },
        status: :unauthorized unless current_user.present?
   end
end

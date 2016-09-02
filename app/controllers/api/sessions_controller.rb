class Api::SessionsController < ApplicationController	
	def create
	    user_password = params[:session][:password]
	    user_email = params[:session][:email]
	    user = User.where(email: user_email).first
	    if (user.present? && (user.valid_password? user_password))
			sign_in user
			user.generate_authentication_token!
			user.save
			render json: user, status: 200, location: [:api, user]
	    else
           render json: { errors: "Invalid email or password" }, status: 422
	    end
    end

    def destroy
	    user = User.find_by(auth_token: params[:id])
	    if user.present?
			user.generate_authentication_token!
			user.save
	    end
	      head 204
    end
end

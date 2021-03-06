class Api::UsersController < ApplicationController
  respond_to :json

  before_action :authenticate_with_token!, only: [:update, :destroy]
  
  def show
    respond_with User.find(params[:id])
  end

  def index
    respond_with User.all
  end


  def create
    user = User.new(user_params)
      if user.save
        render json: user, status: 201 , location: [:api, user]
      else
        render json: { errors: user.errors }, status: 422
      end
  end


  # def create
  #  generated_password = Devise.friendly_token.first(8)
  #  @user = User.create!(email: params[:user][:email], password: generated_password, password_confirmation: generated_password)
  #  NotificationMailer.send_signup_email(@user, generated_password).deliver_now
  #  render json: @user, status: 200
  # end
 

  def update
    user = current_user
    if user.update(user_params)
      render json: user, status: 200, location: [:api, user]
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    head 204
  end


  #   def destroy
  #    current_user.destroy
  #    head 204
  #   end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end

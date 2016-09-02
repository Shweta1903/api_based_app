class Api::BlocksController < ApplicationController
    respond_to :json

    before_action :authenticate_with_token!
    
    def blocks
      block = Block.where(blocker_id: current_user.id, user_id: params[:user_id]).first
      if block.present?
        render json: {success: false, message: "You have already blocked this user" }
      else
        block = Block.create(blocker_id: current_user.id, user_id: params[:user_id])
        render json: {success: true, message: "You have blocked this user" }
      end
    end

	def blocked_users
	  blocked_users = current_user.blocked_users
	  render json: {blocked_users: blocked_users}	
	end

	def blockers
	  blockers = current_user.blockers
	  render json: {blockers: blockers}
	end

    def neutral_users
	  neutral_users = User.all - current_user.blocked_users - current_user.blockers - [current_user]
	  render json: {neutral_users: neutral_users}
	end
end


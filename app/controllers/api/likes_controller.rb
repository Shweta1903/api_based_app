class Api::LikesController < ApplicationController
    
    respond_to :json

    before_action :authenticate_with_token!

	def like_dislike
	  like = Like.where(liker_id: current_user.id, user_id: params[:user_id]).first_or_initialize
	  like.like_status = params[:like_status]
	  like.save	

	  if(params[:like_status] == "true")
		render json: {success: true, message: "liked" }
	   else
	   	render json: {success: true, message: "disliked" }
	   end
	end

	def liked_users
		liked_users = current_user.liked_users
		render json: {liked_users: liked_users}
	end

	def disliked_users
		disliked_users = current_user.disliked_users
		render json: {disliked_users: disliked_users}
	end

	def my_likers
	  my_likers = current_user.my_likers
	  render json: {my_likers: my_likers}
	end

	def my_dislikers
	  my_dislikers = current_user.my_dislikers
	  render json: {my_dislikers: my_dislikers}	
	end


	def other_user
		other_users = User.all - current_user.liked_users - current_user.disliked_users - [current_user]
		render json: {other_users: other_users}
	end


end

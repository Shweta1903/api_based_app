class Api::VotingsController < ApplicationController
   respond_to :json
   before_action :authenticate_with_token!
 

  def voting_disvoting
    article = Article.where(id: params[:vote][:article_id]).first 
    if article.user_id != current_user.id
	    vote = Vote.where(voter_id: current_user.id, article_id: params[:vote][:article_id]).first_or_initialize
	    vote.vote_status = params[:vote][:vote_status]
	    vote.save
      if(params[:vote][:vote_status] == "true")
        
        Petition.check_petition(article)
        render json: {success: true, message: "voted" }
      else
        render json: {success:true, message: "unvoted"}
      end
    else
      render json: {message: 'You cannot vote your own article'}
    end
  end
end























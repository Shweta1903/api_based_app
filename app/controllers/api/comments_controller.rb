class Api::CommentsController < ApplicationController

  before_action :authenticate_with_token!

	def create
	  article = Article.where(id: params[:comment][:article_id]).first
	  if article.present?
      comment = current_user.comments.build(comment_params)
      comment.save
      Petition.check_petition(article)
      render json: comment, status: 201
    else
      render json: {message: 'Article not found with this id'}, status: 201
    end
  end
 
  private
    def comment_params
      params.require(:comment).permit(:text,:article_id,:user_id,:parent_comment_id)
    end
end

class Api::ConversationsController < ApplicationController
   respond_to :json
  
  def index
    respond_with Conversation.all
  end

  def create
    if Conversation.between(current_user.id, params[:recipient_id]).present?
      conversation = Conversation.between(current_user.id, params[:recipient_id]).first
    else
      conversation = Conversation.create!(sender_id: current_user.id, recipient_id: params[:recipient_id])
    end
     conversation.messages << Message.create(body: params[:message], read: true)
     render json: { conversation_id: conversation.id, messages: conversation.messages }
  end

  ## Get conversation messages if present otherwise sent an empty array
  def list_messages
	 messages = []
    if Conversation.between(current_user.id, params[:recipient_id]).present?
      conversation = Conversation.between(current_user.id, params[:recipient_id]).first
  	  messages = conversation.messages
    end
    render json: {conversation: messages}
  end
end
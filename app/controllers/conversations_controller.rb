class ConversationsController < ApplicationController
  def create
    @conversation = Conversation.get
    respond_to do |format|
      format.js
    end
  end

  def close
    @conversation = Conversation.find(params[:id])
    respond_to do |format|
      format.js
    end
  end
end
class ConversationBroadcastJob < ApplicationJob
  queue_as :default

  def perform
    conversation = Conversation.get

    valid_users = User.valid_users
    all_users = User.all

    all_users.each do |recipient|
      broadcast_to_recipient(recipient, valid_users, all_users)
    end
  end

  private

  def broadcast_to_recipient(recipient, valid_users, all_users)
    ActionCable.server.broadcast(
      "new-conversations-#{recipient.id}",
      message: render_message(valid_users, all_users),
      conversation_id: message.conversation_id
    )
  end

  def render_message(valid_users, all_users)
    ApplicationController.render(
      partial: 'home/index_one',
      locals: { valid_users: valid_users, all_users: all_users }
    )
  end

end
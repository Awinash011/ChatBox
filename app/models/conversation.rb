class Conversation < ApplicationRecord

  has_many :messages, dependent: :destroy
  after_destroy_commit { ConversationBroadcastJob.perform_later() }

  def self.get
    conversation = Conversation.last
    return conversation if conversation.present?
    Conversation.create
  end

end
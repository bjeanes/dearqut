class RenameMessagesSpamStatusToModerationStatus < ActiveRecord::Migration
  def self.up
    rename_column :messages, :spam_status, :moderation_status
  end

  def self.down
    rename_column :messages, :moderation_status, :spam_status
  end
end

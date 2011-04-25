class AddUserIdToDelayedJob < ActiveRecord::Migration
  def self.up
    add_column :delayed_jobs, :user_id, :integer
  end

  def self.down
    remove_column :delayed_jobs, :user_id
  end
end

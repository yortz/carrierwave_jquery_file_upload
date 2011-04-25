class AddStateToDelayedJob < ActiveRecord::Migration
  def self.up
    add_column :delayed_jobs, :state, :string
  end

  def self.down
    remove_column :delayed_jobs, :state
  end
end

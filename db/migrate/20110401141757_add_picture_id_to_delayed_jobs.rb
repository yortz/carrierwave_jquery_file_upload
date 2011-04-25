class AddPictureIdToDelayedJobs < ActiveRecord::Migration
  def self.up
    add_column :delayed_jobs, :picture_id, :integer
  end

  def self.down
    remove_column :delayed_jobs, :picture_id
  end
end

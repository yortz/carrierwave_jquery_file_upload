class AddStatusToPicture < ActiveRecord::Migration
  def self.up
    add_column :pictures, :status, :string
    remove_column :pictures, :state
  end

  def self.down
    remove_column :pictures, :status
    add_column :pictures, :state, :default => "pending"
  end
end

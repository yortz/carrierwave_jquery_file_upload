class AddStateToPicture < ActiveRecord::Migration
  def self.up
    add_column :pictures, :state, :string
  end

  def self.down
    remove_column :pictures, :state
  end
end

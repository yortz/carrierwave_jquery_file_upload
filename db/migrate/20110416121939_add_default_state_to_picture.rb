class AddDefaultStateToPicture < ActiveRecord::Migration
  def self.up
    change_column :pictures, :state, :string, :default => "pending"
  end

  def self.down
    change_column :pictures, :state, :string
  end
end

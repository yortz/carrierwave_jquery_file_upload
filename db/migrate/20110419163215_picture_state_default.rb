class PictureStateDefault < ActiveRecord::Migration
  def self.up
    change_column :pictures, :state, :string
  end

  def self.down
    change_column :pictures, :state, :string, :default => "pending"
  end
end

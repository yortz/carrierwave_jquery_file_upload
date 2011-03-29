class AddFileTmpToPictures < ActiveRecord::Migration
  def self.up
    add_column :pictures, :file_tmp, :string
  end

  def self.down
    remove_column :pictures, :file_tmp
  end
end

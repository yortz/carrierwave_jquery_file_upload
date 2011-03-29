class Picture < ActiveRecord::Base
  validates_presence_of  :title, :description, :file
  mount_uploader :file, ImageUploader
  store_in_background :file
end

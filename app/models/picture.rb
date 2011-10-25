class Picture < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  validates_presence_of :title, :description, :file
  mount_uploader :file, ImageUploader
  
  #one convenient method to pass jq_upload the necessary information
  def to_jq_upload
  {
    "id" => read_attribute(:id),
    "title" => read_attribute(:title),
    "description" => read_attribute(:description),
    "name" => read_attribute(:file),
    "size" => file.size,
    "url" => file.url,
    "thumbnail_url" => file.thumb.url,
    "delete_url" => picture_path(:id => id),
    "delete_type" => "DELETE" 
   }
  end
end

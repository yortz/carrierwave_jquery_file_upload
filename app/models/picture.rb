class Picture < ActiveRecord::Base
  after_destroy :remove_file_tmp_dir, :delete_enqueued_job
  before_create :pending
  belongs_to :user
  
  validates_presence_of  :title, :description
  mount_uploader :file, ImageUploader
  store_in_background :file, PictureWorker
  
  def pending
    self.status = "pending"
  end
  def temporary_filename
    self.file_tmp.gsub(/.*\//, "") if self.file_tmp.present?
  end
  
  def remove_file_tmp_dir
    FileUtils.rm_rf([Rails.root, "public", self.file.cache_dir, self.file_tmp.gsub(/\/.*/, "")].join("/"))
  end
  
  def delete_enqueued_job
    jobs = DelayedJob.find_all_by_picture_id(self.id)
    jobs.each { |job| job.destroy }
  end

end



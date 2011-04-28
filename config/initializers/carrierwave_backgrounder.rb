CarrierWave::Backgrounder::ORM::Base.module_eval do
  ##
  # #store_in_background  will process, version and store uploads in a background process.
  #
  # class User < ActiveRecord::Base
  #   mount_uploader :avatar, AvatarUploader
  #   store_in_background :avatar
  # end
  # 
  # The above adds a User#process_upload method which can be used at times when you want to bypass
  # background storage and processing.
  #   
  #   @user.process_upload = true
  #   @user.save
  #
  # You can also pass in your own workers using the second argument in case you need other things done
  # durring processing.
  #
  #   class User < ActiveRecord::Base
  #     mount_uploader :avatar, AvatarUploader
  #     store_in_background :avatar, CustomWorker
  #   end
  #
  def store_in_background(column, worker=::CarrierWave::Workers::StoreAsset)
    send :after_save, :"enqueue_#{column}_background_job"
    
    class_eval  <<-RUBY, __FILE__, __LINE__ + 1
      attr_accessor :process_upload, :picture_id, :state
      
      def write_#{column}_identifier
        super() and return if process_upload
        unless self.#{column}_tmp.present?
          self.#{column}_tmp = _mounter(:#{column}).cache_name
        end
      end
    
      def store_#{column}!
        super() if process_upload
      end
      
      def enqueue_#{column}_background_job
        unless process_upload
          job = DelayedJob.find_by_picture_id(id)
          unless job
            picture = Picture.find(id)
            picture_job = ::Delayed::Job.enqueue(#{worker}.new(self.class, id, #{column}.mounted_as), :priority => 0, :run_at => nil, :picture_id => id, :state => "pending")
            picture_job.update_attribute("user_id", picture.user_id)
          end
        end
      end
    RUBY
  end
end
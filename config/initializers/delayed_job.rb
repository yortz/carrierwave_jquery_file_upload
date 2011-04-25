class DelayedJob < ActiveRecord::Base;end

Delayed::Backend::Base::ClassMethods.module_eval do
  # Add a job to the queue
  def enqueue(*args)
    options = {
      :priority => Delayed::Worker.default_priority
    }.merge!(args.extract_options!)

    options[:payload_object] ||= args.shift

    if args.size > 0
      warn "[DEPRECATION] Passing multiple arguments to `#enqueue` is deprecated. Pass a hash with :priority and :run_at."
      options[:priority] = args.first || options[:priority]
      options[:run_at]   = args[1]
      options[:picture_id] = args[2]
      options[:state] = args[3]
    end

    unless options[:payload_object].respond_to?(:perform)
      raise ArgumentError, 'Cannot enqueue items which do not respond to perform'
    end
    
    if Delayed::Worker.delay_jobs
      self.create(options).tap do |job|
        job.hook(:enqueue)
      end
    else
      options[:payload_object].perform
    end
  end
  
end

Delayed::Backend::ActiveRecord::Job.class_eval do
  
  scope :ready_to_run, lambda {|worker_name, max_run_time|
    where(['(run_at <= ? AND (locked_at IS NULL OR locked_at < ?) OR locked_by = ?) AND failed_at IS NULL AND state LIKE \'%uploading%\'', db_time_now, db_time_now - max_run_time, worker_name])
  }
  
end

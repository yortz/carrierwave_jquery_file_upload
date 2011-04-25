class ApplicationController < ActionController::Base
  protect_from_forgery
  # def after_sign_in_path_for(resource_or_scope)
  #   if resource_or_scope.is_a?(current_user)
  #     current_user_pictures_url(current_user)
  #   else
  #     super
  #   end
  # end
  
  def delayed_job_admin_authentication
    # authentication_logic_goes_here
  end
end

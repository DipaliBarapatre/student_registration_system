class ApplicationController < ActionController::Base
	before_action :authenticate_user!
	protect_from_forgery with: :null_session

	def after_sign_in_path_for(resource)
      if resource.role == 'Admin'
        students_path
      else
        resource.is_verify? ?  student_path(resource) : root_path
      end
    end

    def after_sign_out_path_for resource
      root_path
    end

end

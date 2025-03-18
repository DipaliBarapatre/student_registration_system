class StudentsController < ApplicationController

	before_action :get_student_details, only: [:show, :edit, :update, :verify]

	before_action :validate_csv_file, only: [:import]

	def index
	  @students = User.students 
	end

	def show; end

	def edit; end

	def update
      if @student.update(student_params)
        redirect_to students_path, notice: 'Student details updated successfully!'
      else
        render :edit
      end
    end

    def verify
    	@student.update(is_verify: true)
    	VerificationEmailJob.set(wait: 5.seconds).perform_later(@student)
    	redirect_to students_path, notice: 'Student verify successfully'
    end

    def import
      if params[:file].present?
        User.import(params[:file])
        redirect_to students_path, notice: "Students imported successfully!"
      else
        redirect_to students_path, alert: "Please upload a CSV file."
      end
  end


	private

	def get_student_details
		@student = User.find(params[:id])
	end

	def student_params
		params.permit(:name, :date_of_birth, :address, :photo)
	end

	def validate_csv_file
		file = params[:file]
	  unless file.content_type == "text/csv" || file.content_type == "application/vnd.ms-excel"
        redirect_to students_path, alert: "Invalid file type. Please upload a CSV file."
        return
      end
	end
end

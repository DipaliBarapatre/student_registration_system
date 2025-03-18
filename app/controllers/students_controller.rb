class StudentsController < ApplicationController

	before_action :get_student_details, only: [:show, :edit, :update]

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
    end


	private

	def get_student_details
		@student = User.find(params[:id])
	end

	def student_params
		params.permit(:name, :date_of_birth, :address, :photo)
	end
end

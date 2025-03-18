class StudentsController < ApplicationController

	def index
	  @students = User.students 
	  redirect_to @students
	end

	def show 
		debugger
	end
end

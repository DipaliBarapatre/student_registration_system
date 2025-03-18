class StudentMailer < ApplicationMailer
	default from: 'notifications@example.com'

  def verify_email(student)
    @student = student
    mail(to: @student.email, subject: "Congratulations on Your verification!")
  end
end

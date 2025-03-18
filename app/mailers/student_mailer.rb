class StudentMailer < ApplicationMailer
	default from: 'notifications@example.com'

  def verify_email(student)
    @student = student
    mail(to: @student.email, subject: "Congratulations on Your verification!")
  end

   def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: "Welcome to Our Platform!")
  end

   def student_register(user)
   	@user = user
    mail(to: 'admin@gmail.com', subject: "New Student Signed Up")
  end

   def good_morning_email(user)
    @user = user
    mail(to: @user.email, subject: "Good Morning, #{@user.name}!")  
  end

   def birthday_email(user)
    @user = user
    mail(to: @user.email, subject: "Happy Birthday, #{@user.name}! 🎉")  
  end
end

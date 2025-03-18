class VerificationEmailJob < ApplicationJob
  queue_as :default

  def perform(student)
    # Do something later
    StudentMailer.verify_email(student).deliver_now
  end
end

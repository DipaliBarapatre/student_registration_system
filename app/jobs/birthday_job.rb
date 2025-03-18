class BirthdayJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    today = Date.today
    users = User.where("DATE(date_of_birth) = ?", today)  # Select users with today's birthday

    users.each do |user|
      UserMailer.birthday_email(user).deliver_later
    end
  end
end

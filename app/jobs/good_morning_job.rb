class GoodMorningJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    User.where.not(email: nil, role: 'Student').find_each do |user|
      UserMailer.good_morning_email(user).deliver_later
    end
  end
end

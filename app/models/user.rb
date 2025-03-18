class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: ['Admin', 'Student']

  scope :students, -> { where(:role => 'Student') }

  has_one_attached :photo

  validates :name, presence: true

  validates :date_of_birth, :presence => true
  validate :validate_age

  private

  def validate_age
      if date_of_birth.present? && date_of_birth > 18.years.ago
          errors.add(:date_of_birth, 'You should be over 18 years old.')
      end
  end 
end

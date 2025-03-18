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
      if date_of_birth.present? && date_of_birth > Date.today
          errors.add(:date_of_birth, 'Date of birth should be past date')
      end
  end 
end

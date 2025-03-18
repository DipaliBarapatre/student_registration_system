  require 'csv'

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

  after_create :update_role

   def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      student_data = row.to_hash
      student = User.find_or_initialize_by(email: student_data["email"])
      student.password = 'testing123'
      student.role = 'Student'
      student.update(student_data) # Updates or creates new student
    end
  end

  def self.to_csv
    attributes = %w[name email date_of_birth] # Column headers

    CSV.generate(headers: true) do |csv|
      csv << attributes # Add headers

      all.find_each do |student|
        csv << student.attributes.values_at(*attributes)
      end
    end
  end

  private

  def validate_age
      if date_of_birth.present? && date_of_birth > Date.today
          errors.add(:date_of_birth, 'Date of birth should be past date')
      end
  end 

  def update_role
    self.update(role: 'Student') if self.role.nil?
  end


 
  end

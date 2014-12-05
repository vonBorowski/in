class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :registerable, :database_authenticatable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :time_entries
  before_destroy :check_for_time_entries

  validates :first_name, presence: true
  validates :last_name, presence: true

  private
    def check_for_time_entries
      if time_entries.any?
        errors[:base] << "Cannot delete user that has time entries."
        return false
      end
    end
end

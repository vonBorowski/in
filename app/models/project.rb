class Project < ActiveRecord::Base
  belongs_to :organization
  has_many :tasks
  before_destroy :check_for_tasks

  validates :name, presence: true
  validates :description, presence: true
  validates :organization, presence: true

  private

    def check_for_tasks
      if tasks.any?
        errors[:base] << "Cannot delete project that has tasks."
        return false
      end
    end
end

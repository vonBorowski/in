class TimeEntry < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper

  belongs_to :user
  belongs_to :task
  delegate :project, to: :task
  delegate :organization, to: :project

  validates :user, presence: true
  validates :task, presence: true
  validates :starts_at, presence: true
  validates :ends_at, presence: true

  def duration
    (ends_at - starts_at) / 1.hour
  end

  module SearchScope
    def self.included(base)
      base.has_scope :task_id
      base.has_scope :project_id
      base.has_scope :organization_id
    end
  end

  scope :task_id, -> task_id { where(:task_id => task_id) }
  scope :project_id, -> project_id { joins(:task).where("tasks.project_id = ?", project_id) }
  scope :organization_id, -> organization_id { joins(task: :project).where("projects.organization_id = ?", organization_id) }
end

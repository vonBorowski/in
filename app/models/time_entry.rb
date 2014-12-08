class TimeEntry < ActiveRecord::Base
  belongs_to :user
  belongs_to :task

  validates :user_id, presence: true
  validates :task_id, presence: true
  validates :starts_at, presence: true
  validates :ends_at, presence: true

  def duration
    (ends_at - starts_at) / 1.hour
  end

  def self.by_year(year)
    where('extract(year from starts_at) = ? or extract(day from ends_at) = ?', year, year)
  end

  def self.by_month(month)
    where('extract(month from starts_at) = ? or extract(day from ends_at) = ?', month, month)
  end

  def self.by_day(day)
    where('extract(day from starts_at) = ? or extract(day from ends_at) = ?', day, day)
  end

  def self.by_task(task_id)
    where('task_id = ?', task_id)
  end

  def self.by_project(project_id)
    joins(:task).where('project_id = ?', project_id)
  end
end

class Task < ApplicationRecord
  belongs_to :user
  enum status: { to_do: 'ToDo', in_progress: 'In Progress', done: 'Done' }
  validates :name, presence: true, uniqueness: { case_sensitive: false, message: 'is already taken, please change the name' }
  validates :description, presence: true, length: { minimum: 4, maximum: 50 }
  validates :date, presence: true
  validates :status, presence: true

  before_save :capitalize_name
  before_save :mark_as_overdue
  before_destroy :check_if_done

  private

  def capitalize_name
    self.name = name.split.map(&:capitalize).join(' ')
  end

  def mark_as_overdue
    self.overdue = date < Date.today && to_do?
  end

  def check_if_done
    unless done?
      errors.add(:base, "You can only delete tasks that are done")
      throw :abort
    end
  end
end

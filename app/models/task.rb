class Task < ApplicationRecord
  belongs_to :user
  enum status: { to_do: 'ToDo', in_progress: 'In Progress', done: 'Done' }
  validates :name, presence: true, uniqueness: { case_sensitive: false, message: 'is already taken, please change the name' }
  validates :description, presence: true, length: { minimum: 4, maximum: 50 }
  validates :date, presence: true
  validates :status, presence: true

  before_create :capitalize_name

  private

  def capitalize_name
    self.name = name.split.map(&:capitalize).join(' ')
  end
end

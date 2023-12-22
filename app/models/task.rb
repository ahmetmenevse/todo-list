class Task < ApplicationRecord
  belongs_to :user
  enum status: { to_do: 'ToDo', in_progress: 'In Progress', done: 'Done' }
end

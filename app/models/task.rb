class Task < ApplicationRecord
  enum status: { to_do: 'ToDo', in_progress: 'In Progress', done: 'Done' }
end
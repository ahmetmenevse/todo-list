class ChangeCompletedToStatus < ActiveRecord::Migration[7.0]
  def change
    rename_column :tasks, :completed, :status
    change_column :tasks, :status, :string
  end
end

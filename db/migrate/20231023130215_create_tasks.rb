class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :name
      t.text :description
      t.decimal :duration
      t.string :priority
      t.date :date
      t.datetime :start_time
      t.boolean :completed

      t.timestamps
    end
  end
end

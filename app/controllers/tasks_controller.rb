class TasksController < ApplicationController
  before_action :set_task, only: [:edit, :update, :destroy]
  def index
    @to_do_tasks = Task.where(status: 'to_do')
    @in_progress_tasks = Task.where(status: 'in_progress')
    @done_tasks = Task.where(status: 'done')
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path(@tasks)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path(@tasks)
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path status: :see_other
  end

  private


  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, 
      :description,
      :duration,
      :priority,
      :date,
      :start_time,
      :status)
  end
end

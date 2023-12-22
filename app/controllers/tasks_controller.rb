class TasksController < ApplicationController
  before_action :set_task, only: [:edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    if params[:query].present?
      sql_subquery = <<~SQL
        tasks.name @@ :query
        OR tasks.description @@ :query
      SQL
    end
    @to_do_tasks = current_user.tasks.where(status: 'to_do').where(params[:query].present? ? sql_subquery : "", query: "%#{params[:query]}%")
    @in_progress_tasks = current_user.tasks.where(status: 'in_progress').where(params[:query].present? ? sql_subquery : "", query: "%#{params[:query]}%")
    @done_tasks = current_user.tasks.where(status: 'done').where(params[:query].present? ? sql_subquery : "", query: "%#{params[:query]}%")
  end

  def new
    @task = current_user.tasks.build
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to root_path, notice: 'Task was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to root_path, notice: 'Task was successfully edited.'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to root_path, notice: 'Task was successfully deleted.'
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
      :status)
  end
end

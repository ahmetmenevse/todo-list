class TasksController < ApplicationController
  before_action :set_task, only: [:edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @to_do_tasks = apply_search_condition(current_user.tasks.where(status: 'to_do'))
    @in_progress_tasks = apply_search_condition(current_user.tasks.where(status: 'in_progress'))
    @done_tasks = apply_search_condition(current_user.tasks.where(status: 'done'))
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

  def apply_search_condition(query)
    if params[:query].present?
      sql_subquery = <<~SQL
        tasks.name @@ :query
        OR tasks.description @@ :query
      SQL
      query.where(sql_subquery, query: "%#{params[:query]}%")
    else
      query
    end
  end
end

class TasksController < ApplicationController
  before_action :set_task, only: %i[edit update destroy]
  before_action :authenticate_user!

  def index
    @to_do_tasks = apply_search_condition(current_user.tasks.to_do)
    @in_progress_tasks = apply_search_condition(current_user.tasks.in_progress)
    @done_tasks = apply_search_condition(current_user.tasks.done)
  end

  def new
    @task = current_user.tasks.build
  end

  def create
    @task = current_user.tasks.build(task_params)
    begin
      @task.save!
      redirect_to root_path, notice: 'Task was successfully created.'
    rescue ActiveRecord::RecordInvalid
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to root_path, notice: 'Task was successfully edited.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @task.destroy
      redirect_to root_path, notice: 'Task was successfully deleted.'
    else
      error_message = @task.errors.full_messages.to_sentence
      redirect_to root_path, alert: error_message
    end
  end

  private

  def set_task
    begin
      @task = Task.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path, alert: 'Task not found'
    end
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

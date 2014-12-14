class TaskController < ApplicationController
  respond_to :html, :json, :xml

  before_filter :authenticate_user!
  before_action :set_project, only: [:index, :new, :create]
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    if @project
      @tasks = @project.tasks.order('id ASC')
    else
      @tasks = Task.order('id ASC')
    end
    respond_with(@tasks)
  end

  def show
    respond_with(@task)
  end

  def new
    @task = Task.new
    @task.project = @project
    respond_with(@task)
  end

  def edit
    respond_with(@task)
  end

  def create
    @task = Task.new(task_params)
    @task.project = @project
    @task.save
    respond_with(@task, location: project_task_index_path(@project))
  end

  def update
    @task.update_attributes(task_params)
    respond_with(@task, location: project_task_index_path(@task.project))
  end

  def destroy
    project = @task.project
    @task.destroy
    respond_with(nil, location: project_task_index_path(project))
  end

  private

  def set_project
    @project = Project.find_by(id: params[:project_id]) if params[:project_id]
  end

  def set_task
    @task = Task.find_by(id: params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :description)
  end
end

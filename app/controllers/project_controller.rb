class ProjectController < ApplicationController
  respond_to :html, :json, :xml

  before_filter :authenticate_user!
  before_action :set_organization, only: [:index, :new, :create]
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
    if @organization
      @projects = @organization.projects.order('id ASC')
    else
      @projects = Project.order('id ASC')
    end
    respond_with(@projects)
  end

  def show
    respond_with(@project)
  end

  def new
    @project = Project.new
    @project.organization = @organization
    respond_with(@project)
  end

  def edit
    respond_with(@project)
  end

  def create
    @project = Project.new(project_params)
    @project.organization = @organization
    @project.save
    respond_with(@project)
  end

  def update
    @project.update_attributes(project_params)
    respond_with(@project)
  end

  def destroy
    organization = @project.organization
    @project.destroy
    respond_with(nil, location: organization_project_index_path(organization))
  end

  private

  def set_organization
    @organization = Organization.find_by(id: params[:organization_id]) if params[:organization_id]
  end

  def set_project
    @project = Project.find_by(id: params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :description, :budget, :block)
  end
end

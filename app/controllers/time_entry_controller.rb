class TimeEntryController < ApplicationController
  respond_to :html, :json, :xml

  before_filter :authenticate_user!
  before_action :set_user, only: [:index, :new, :create]
  before_action :set_time_entry, only: [:show, :edit, :update, :destroy]

  def index
    @time_entries = @user.time_entries
    @time_entries = @time_entries.by_project(params[:project_id]) if params[:project_id]
    @time_entries = @time_entries.by_task(params[:task_id]) if params[:task_id]
    @time_entries = @time_entries.by_year(params[:year]) if params[:year]
    @time_entries = @time_entries.by_month(params[:month]) if params[:month]
    @time_entries = @time_entries.by_day(params[:day]) if params[:day]
    @time_entries = @time_entries.order('starts_at DESC')
    respond_with(@time_entries)
  end

  def show
    respond_with(@time_entry)
  end

  def new
    @time_entry = TimeEntry.new
    @time_entry.user = @user
    respond_with(@time_entry)
  end

  def edit
    respond_with(@time_entry)
  end

  def create
    @time_entry = TimeEntry.new(time_entry_params)
    @time_entry.user = @user
    @time_entry.save
    respond_with(@time_entry)
  end

  def update
    @time_entry.update_attributes(time_entry_params)
    respond_with(@time_entry)
  end

  def destroy
    user = @time_entry.user
    @time_entry.destroy
    respond_with(@time_entry,location: user_time_entry_index_path(user))
  end

  private

  def set_user
    @user = User.find_by(id: params[:user_id])
  end

  def set_time_entry
    @time_entry = TimeEntry.find_by(id: params[:id])
  end

  def time_entry_params
    params.require(:time_entry).permit(:starts_at, :ends_at, :memo, :task_id)
  end
end
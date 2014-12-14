class UserController < ApplicationController
  respond_to :html, :json, :xml

  before_filter :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
     @users = User.order('first_name ASC')
     respond_with(@users)
  end

  def show
     respond_with(@user)
  end

  def new
    @user = User.new
    respond_with(@user)
  end

  def create
    @user = User.new(user_params)
    @user.save
    respond_with(@user, location: user_index_path)
  end

  def update
    #authorize @user, :update?

    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    @user.update_attributes(user_params)
    respond_with(@user, location: user_index_path)
  end

  def edit
      #authorize @user, :edit?
      respond_with(@user)
  end

  def destroy
    @user.destroy
    respond_with(nil, location: user_index_path)
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :location, :about, :profile_picture, :password, :password_confirmation, :admin, :organization_id )
  end
end

class OrganizationController < ApplicationController
  respond_to :html, :json, :xml

  before_filter :authenticate_user!
  before_action :set_organization, only: [:show, :edit, :update, :destroy]

  def index
    @organizations = Organization.order('id ASC')
    respond_with(@organizations)
  end

  def show
    respond_with(@organization)
  end

  def new
    @organization = Organization.new
    respond_with(@organization)
  end

  def edit
    respond_with(@organization)
  end

  def create
    @organization = Organization.create(organization_params)
    respond_with(@organization)
  end

  def update
    @organization.update_attributes(organization_params)
    respond_with(@organization)
  end

  def destroy
    @organization.destroy
    respond_with(nil, location: organization_index_path)
  end

  private

  def set_organization
    @organization = Organization.find_by(id: params[:id])
  end

  def organization_params
    params.require(:organization).permit(:name, :full_name, :cnpj, :address1, :address2, :address3, :zipcode, :city, :state, :country, :website, :primary_email, :is_company, :is_client, :is_vendor)
  end
end

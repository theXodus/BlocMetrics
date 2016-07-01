class RegisteredApplicationsController < ApplicationController

  before_action :find_application, except: [:index, :new, :create]

  def index
    @registered_applications = current_user.registered_applications.all
  end

  def show
    @events = @registered_application.events.group_by(&:name)
  end

  def new
    @registered_application = RegisteredApplication.new
  end

  def create
    @registered_application = current_user.registered_applications.build(app_params)

    if @registered_application.save
      flash[:notice] = "Application Successfully Registered"
      redirect_to @registered_application
    else
      flash[:notice] = "Application Was Not Able to Register at this Time"
      render :new
    end
  end

  def edit
  end

  def update
    if @registered_application.update(app_params)
      flash[:notice] = "Application Updated Successfully"
      redirect_to @registered_application
    else
      flash[:alert] = "Cannot Update Application at this Time."
      redirect_to :edit
    end
  end

  def destroy
    if @registered_application.delete
      flash[:notice] = "Application Unregistered"
      redirect_to registered_applications_path
    else
      flash[:alert] = "Cannot Unregister at this Time"
    end
  end

  private

  def find_application
    @registered_application = current_user.registered_applications.find(params[:id])
  end

  def app_params
    params.require(:registered_application).permit(:name, :url)
  end
end

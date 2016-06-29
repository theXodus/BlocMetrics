class RegisteredApplicationsController < ApplicationController

  before_action :find_application, except: [:index, :new, :create]

  def index
    @registeredApplications = current_user.registered_applications.all
  end

  def show
  end

  def new
    @registeredApplication = RegisteredApplication.new
  end

  def create
    @registeredApplication = current_user.registered_applications.build(app_params)

    if @registeredApplication.save
      flash[:notice] = "Application Successfully Registered"
      redirect_to @registeredApplication
    else
      flash[:notice] = "Application Was Not Able to Register at this Time"
      render :new
    end
  end

  def edit
  end

  def update
    if @registeredApplication.update(app_params)
      flash[:notice] = "Application Updated Successfully"
      redirect_to @registeredApplication
    else
      flash[:alert] = "Cannot Update Application at this Time."
      redirect_to :edit
    end
  end

  def destroy
    if @registeredApplication.delete
      flash[:notice] = "Application Unregistered"
      redirect_to registered_applications_path
    else
      flash[:alert] = "Cannot Unregister at this Time"
    end
  end

  private

  def find_application
    @registeredApplication = current_user.registered_applications.find(params[:id])
  end

  def app_params
    params.require(:registered_application).permit(:name, :url)
  end
end

class RegisteredApplicationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @registered_applications = @user.registered_applications.all
  end

  def show
    @user = User.find(params[:user_id])
    @registered_application = @user.registered_applications.find(params[:id])
    @events = @registered_application.events.group_by(&:name)
  end

  def new
    @user = User.find(params[:user_id])
    @registered_application = @user.registered_applications.new
  end

  def create
    @user = User.find(params[:user_id])
    @registered_application = @user.registered_applications.build(reg_app_params)
    if @registered_application.save
      flash[:notice] = "#{@registered_application.name} registered successfully."
      redirect_to  [@user, @registered_application]
    else
      flash[:error] = "An error occurred while registering your application. Please try again."
      render :new
    end

  end

  def edit
    @user = User.find(params[:user_id])
    @registered_application = @user.registered_applications.find(params[:id])
  end

  def update
    @user = User.find(params[:user_id])
    @registered_application = @user.registered_applications.find(params[:id])
    if @registered_application.update_attributes!(reg_app_params)
      flash[:notice] = "#{@registered_application.name} updated."
      redirect_to [@user, @registered_application]
    else
      flash[:error] = "An error occurred. Please try again."
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @registered_application = @user.registered_applications.find(params[:id])
    if @registered_application.destroy
      flash[:notice] = "#{@registered_application.name} deleted."
      redirect_to root_path
    else
      flash[:error] = "An error occurred. Please try deleting the application again."
      render :show
    end
  end

  private
  def reg_app_params
    params.require(:registered_application).permit(:name, :url)
  end
end

class DeveloperAppsController < ApplicationController

  def show
    @app = DeveloperApp.where(api_key: developer_app_params[:client_api_key])

    render json: { developer_app: DeveloperAppRepresenter.represent(@developer_app) }
  end

  def create
    @developer_app = DeveloperApp.new(developer_app_params)

    if @developer_app.save
      render json: { developer_app: DeveloperAppRepresenter.represent(@developer_app) }
    else
      render json: { error: "error" }
    end
  end

  protected

  def developer_app_params
    params
      .require(:developer_app)
      .permit(
        :name,
        :client_api_key,
        :user_id
      )
  end
end

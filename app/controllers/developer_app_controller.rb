class DeveloperAppController < ApplicationController

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

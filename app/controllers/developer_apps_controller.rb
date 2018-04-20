class DeveloperAppsController < ApplicationController

  def show
    @app = DeveloperApp.where(api_key: developer_app_params[:developer_key])

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

  def authenticate
    puts '*************'
    puts 'request'
    puts request.body.read

    @developer_app = DeveloperApp.find { |x| x.api_key.key == params[:developer_key] }

    puts 'params'
    puts params

    puts 'params api key'
    puts params[:developer_key]

    puts 'developer app'
    puts @developer_app

    return if @developer_app.nil?

    puts 'developer app was not nil'

    @app_session = AppSession.new(developer_app: @developer_app)
    @app_session.build_device(device_params)

    if @app_session.save!
      puts 'app session saved'
      render json: { app_session: AppSessionRepresenter.represent(@app_session) }
    else
      puts 'app session NOT saved'
      render json: { error: "error" }
    end
  end

  protected

  def developer_app_params
    params
      .require(:developer_app)
      .permit(
        :name,
        :developer_key,
        :user_id
      )
  end

  def device_params
    params
      .require(:device)
      .permit(
        :name,
        :developer_key,
        :user_id,
        :device,
        :device_model,
        :localized_model,
        :device_model_name,
        :name,
        :system_name,
        :system_version,
      )
  end
end

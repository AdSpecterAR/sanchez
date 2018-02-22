class ImpressionsController < ApplicationController
  # skip_before_action :verify_authenticity_token # only for development purposes

  def create
    @impression = Impression.new(impression_params)

    if @impression.save
      render json: { impression: ImpressionRepresenter.represent(@impression) }
    else
      render json: { error: "error" }
    end
  end

  def update
    @impression = Impression.find(params[:id])

    if @impression.update_attributes(impression_params)
      render json: { impression: ImpressionRepresenter.represent(@impression) }
    else
      render json: { error: "error" }
    end
  end


  protected


  def impression_params
    params
      .require(:impression)
      .permit(
        :id,
        :developer_app_id,
        :ad_unit_id,
        :app_session_id,
        :clicked,
        :served,
        :shown,
        :served_at,
        :shown_at,
        :clicked_at
      )
  end
end

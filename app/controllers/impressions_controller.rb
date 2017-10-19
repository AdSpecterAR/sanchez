class ImpressionsController < ApplicationController

  def create
    @impression = Impression.new(impression_params)

    if @impression.save
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
        :developer_app_id,
        :campaign_id,
        :impression_started_at,
        :impression_ended_at,
        :clicked
      )
  end
end

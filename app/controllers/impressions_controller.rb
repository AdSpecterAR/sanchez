class ImpressionsController < ApplicationController
  # skip_before_action :verify_authenticity_token # only for development purposes

  def create
    puts "*********************"
    puts "creating impression"
    puts params
    puts impression_params
    puts "*********************"

    @impression = Impression.new(impression_params)

    if @impression.save
      render json: { impression: ImpressionRepresenter.represent(@impression) }
    else
      render json: { error: "error" }
    end
  end

  def update
    puts "*********************"
    puts "updating impression"
    puts params
    puts impression_params
    puts "*********************"
  end


  protected


  def impression_params
    params
      .require(:impression)
      .permit(
        :impression_started_at,
        :served_at,
        :shown_at,
        :impression_ended_at,
        :developer_app_id,
        :campaign_id,
        :app_session_id,
        :served,
        :shown,
        :shown_for_30_seconds,
        :clicked
      )
  end
end

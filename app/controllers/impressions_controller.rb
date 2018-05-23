class ImpressionsController < ApplicationController
  # skip_before_action :verify_authenticity_token # only for development purposes

  def create
    current_time = Time.current

    @impression = Impression.new(impression_params)
    @impression.id = nil # c-sharp default for int is 0
    @impression.served_at = current_time

    if @impression.save
      # TODO: implement updating corresponding ad unit's 'last_served_at'
      # @impression.serve_ad_unit(current_time)

      render json: { impression: ImpressionRepresenter.represent(@impression) }
    else
      render json: { error: "error" }
    end
  end

  def shown
    @impression = Impression.find(params[:id])
    @impression.shown = true
    @impression.shown_at = Time.now

    render_impression_response(@impression)
  end

  def clicked
    @impression = Impression.find(params[:id])
    @impression.clicked = true
    @impression.clicked_at = Time.now

    render_impression_response(@impression)
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

  def render_impression_response(impression)
    if impression.save
      render json: { impression: ImpressionRepresenter.represent(impression) }
    else
      render json: { error: "error" }
    end
  end

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

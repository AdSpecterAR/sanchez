class ImpressionsController < ApplicationController
  # skip_before_action :verify_authenticity_token # only for development purposes

  #######################################################
  #
  # Impressions can come from two places:
  # 1) directly from our SDKs
  # 2) through an attribution partner (Adjust, Appsflyer)
  #
  #######################################################

  def shown
    @impression = Impression.find(params[:impression_id])
    @impression.shown = true
    @impression.shown_at = Time.now

    render_impression_response(@impression)
  end

  def clicked
    @impression = Impression.find(params[:impression_id])
    @impression.clicked = true
    @impression.clicked_at = Time.now

    render_impression_response(@impression)
  end

  def installed
    @impression = Impression.find(params[:impression_id])
    @impression.installed = true
    @impression.installed_at = Time.now

    render_impression_response(@impression)
  end

  protected

  def render_impression_response(impression)
    if impression.save
      if params[:attribution_partner]
        puts "attribution partner: ", params[:attribution_partner]
        render json: { response: "postback received by AdSpecter server" }
      else
        render json: { impression: ImpressionRepresenter.represent(impression) }
      end
    else
      render json: { error: "error" }
    end
  end
end

class CampaignsController < ApplicationController

  def create
    @campaign = Campaign.new(campaign_params)

    if @campaign.save
      render json: { campaign: CampaignRepresenter.represent(campaign) }
    else
      render json: { error: "error" }
    end
  end

  protected

  def campaign_params
    params
      .require(:campaign)
      .permit(
        :title,
        :description,
        :click_url,
        :ad_unit_url,
        :active
      )
  end
end

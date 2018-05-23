class AdUnitsController < ApplicationController

  def create
    @ad_unit = AdUnit.new(ad_unit_params)

    if @ad_unit.save!
      render json: { ad_unit: AdUnitRepresenter.represent(@ad_unit) }
    else
      render json: { error: "error" }
    end
  end

  def fetch
    @ad_unit = AdUnit.fetch(
      ad_format: ad_unit_params[:ad_format],
      aspect_ratio_width: ad_unit_params[:aspect_ratio_width],
      aspect_ratio_height: ad_unit_params[:aspect_ratio_height]
    )

    render json: { ad_unit: AdUnitRepresenter.represent(@ad_unit) }
  end

  def default
    # TODO: add logic to look at user ad format preferences
    @ad_unit = AdUnit.default_ad_unit

    render json: { ad_unit: AdUnitRepresenter.represent(@ad_unit) }
  end

  protected

  def ad_unit_params
    params
      .require(:ad_unit)
      .permit(
        :title,
        :description,
        :click_url,
        :ad_unit_url,
        :active,
        :last_served_at,
        :ad_format,
        :aspect_ratio_width,
        :aspect_ratio_height,
        :user_id
      )
  end
end

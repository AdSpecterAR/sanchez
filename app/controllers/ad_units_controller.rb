class AdUnitsController < ApplicationController

  def create
    @ad_unit = AdUnit.new(ad_unit_params)

    if @ad_unit.save!
      render json: { ad_unit: AdUnitRepresenter.represent(@ad_unit) }
    else
      render json: { error: "error" }
    end
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
        :user_id
      )
  end
end

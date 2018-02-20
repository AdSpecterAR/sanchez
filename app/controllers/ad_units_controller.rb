class AdUnitsController < ApplicationController

  def create
    @ad_unit = AdUnit.new(ad_unit_params)

    if @ad_unit.save!
      render json: { ad_unit: AdUnitRepresenter.represent(@ad_unit) }
    else
      render json: { error: "error" }
    end
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
        :active
      )
  end
end

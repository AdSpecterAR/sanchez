class TestsController < ApplicationController

  def index
    render json: { image_url: "https://naotw-pd.s3.amazonaws.com/coke_holiday_ooh_aotw.jpg"}
  end

end
